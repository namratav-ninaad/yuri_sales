import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/features/cart/domain/entities/update_cart_qty.dart';
import 'package:yuri_sale/features/cart/domain/usecases/update_cart_qty_uc.dart';
import 'package:yuri_sale/features/product/data/model/category.dart';
import 'package:yuri_sale/features/product/domain/entities/product_filter_data.dart';
import 'package:yuri_sale/features/product/domain/usecases/add_cart_uc.dart';
import 'package:yuri_sale/features/product/domain/usecases/category_uc.dart';
import 'package:yuri_sale/features/product/domain/usecases/product_uc.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCase productUseCase;
  final AddCartUseCase addCartUseCase;
  final CategoryUseCase categoryUseCase;
  final UpdateCartQtyUseCase updateCartQtyUseCase;

  ProductBloc({
    required this.productUseCase,
    required this.addCartUseCase,
    required this.categoryUseCase,
    required this.updateCartQtyUseCase,
  }) : super(const ProductState()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<FetchCategoriesEvent>(_onFetchCategoriesEvent);
    on<AddCartEvent>(_onAddCart);
    on<SelectCategoryEvent>(_onSelectCategory);
    on<RemoveProductFromCart>(_onRemoveProductFromCart);
    on<IncreaseProductQuantity>(_onIncreaseProductQuantity);
    on<SetProductQuantity>(_onSetProductQuantity);
    on<DecreaseProductQuantity>(_onDecreaseProductQuantity);
    on<SyncCartDataToProducts>(_onSyncCartDataToProducts);
  }

  // PENDING PRODUCT QUANTITIES

  final Map<int, int> _pendingProductQuantities = {};

  // DEBOUNCE TIMERS

  final Map<int, Timer> _productQuantityTimers = {};

  // SET PRODUCT QUANTITY (from text field)
  void _onSetProductQuantity(
    SetProductQuantity event,
    Emitter<ProductState> emit,
  ) {
    final int productId = event.productId;
    final int newQty = event.quantity;

    // Guard
    if (newQty < 1) return;

    final int? lineId = state.lineIds[productId];
    if (lineId == null) {
      debugPrint(
        'SetQuantity skipped. Line ID not found for product: $productId',
      );
      return;
    }

    // 1. Optimistic UI update (instant)
    _pendingProductQuantities[productId] = newQty;

    final quantities = Map<int, int>.from(state.cartQuantities);
    quantities[productId] = newQty;

    emit(state.copyWith(cartQuantities: quantities, errorMessage: null));

    debugPrint('PRODUCT SET QTY -> productId: $productId | newQty: $newQty');

    // 2. Debounce API call
    _productQuantityTimers[productId]?.cancel();

    _productQuantityTimers[productId] = Timer(
      const Duration(milliseconds: 500),
      () {
        _callProductQuantityApi(
          productId: productId,
          lineId: lineId,
          quantity: newQty,
        );
      },
    );
  }

  // SYNC CART -> PRODUCT
  void _onSyncCartDataToProducts(
    SyncCartDataToProducts event,
    Emitter<ProductState> emit,
  ) {
    debugPrint('========== SYNC CART -> PRODUCT ==========');
    debugPrint('Cart Quantities: ${event.cartQuantities}');
    debugPrint('Line IDs: ${event.lineIds}');

    emit(
      state.copyWith(
        cartQuantities: event.cartQuantities,
        lineIds: event.lineIds,
      ),
    );
  }

  // INCREASE
  Future<void> _onIncreaseProductQuantity(
    IncreaseProductQuantity event,
    Emitter<ProductState> emit,
  ) async {
    final int productId = event.productId.toInt();

    // GET CURRENT QUANTITY
    //
    // IMPORTANT:
    // If a pending quantity exists, ALWAYS use it.
    //
    // Otherwise use the quantity received from Cart API.
    //

    final int currentQty =
        _pendingProductQuantities[productId] ??
        state.cartQuantities[productId] ??
        1;

    // NEW QUANTITY

    final int newQty = currentQty + 1;

    // SAVE PENDING QUANTITY

    _pendingProductQuantities[productId] = newQty;

    debugPrint(
      'PRODUCT INCREASE -> '
      'productId: $productId | '
      'currentQty: $currentQty | '
      'newQty: $newQty',
    );

    // UPDATE UI IMMEDIATELY

    final quantities = Map<int, int>.from(state.cartQuantities);

    quantities[productId] = newQty;

    emit(state.copyWith(cartQuantities: quantities, errorMessage: null));

    // GET LINE ID

    final int? lineId = state.lineIds[productId];

    if (lineId == null) {
      debugPrint(
        'Increase skipped. '
        'Line ID not found for product: $productId',
      );
      return;
    }

    // CANCEL PREVIOUS TIMER

    _productQuantityTimers[productId]?.cancel();

    // START DEBOUNCE TIMER

    _productQuantityTimers[productId] = Timer(
      const Duration(milliseconds: 500),
      () {
        _callProductQuantityApi(
          productId: productId,
          lineId: lineId,
          quantity: newQty,
        );
      },
    );
  }

  // DECREASE
  Future<void> _onDecreaseProductQuantity(
    DecreaseProductQuantity event,
    Emitter<ProductState> emit,
  ) async {
    final int productId = event.productId.toInt();

    // GET CURRENT QUANTITY

    final int currentQty =
        _pendingProductQuantities[productId] ??
        state.cartQuantities[productId] ??
        1;

    // MINIMUM QUANTITY

    if (currentQty <= 1) {
      return;
    }

    // NEW QUANTITY

    final int newQty = currentQty - 1;

    // SAVE PENDING QUANTITY

    _pendingProductQuantities[productId] = newQty;

    debugPrint(
      'PRODUCT DECREASE -> '
      'productId: $productId | '
      'currentQty: $currentQty | '
      'newQty: $newQty',
    );

    // UPDATE UI IMMEDIATELY

    final quantities = Map<int, int>.from(state.cartQuantities);

    quantities[productId] = newQty;

    emit(state.copyWith(cartQuantities: quantities, errorMessage: null));

    // GET LINE ID

    final int? lineId = state.lineIds[productId];

    if (lineId == null) {
      debugPrint(
        'Decrease skipped. '
        'Line ID not found for product: $productId',
      );
      return;
    }

    // CANCEL PREVIOUS TIMER

    _productQuantityTimers[productId]?.cancel();

    // START DEBOUNCE TIMER

    _productQuantityTimers[productId] = Timer(
      const Duration(milliseconds: 500),
      () {
        _callProductQuantityApi(
          productId: productId,
          lineId: lineId,
          quantity: newQty,
        );
      },
    );
  }

  // UPDATE CART API
  Future<void> _callProductQuantityApi({
    required int productId,
    required int lineId,
    required int quantity,
  }) async {
    try {
      debugPrint('======================================');
      debugPrint('PRODUCT UPDATE CART API');
      debugPrint('productId: $productId');
      debugPrint('lineId: $lineId');
      debugPrint('qty: $quantity');
      debugPrint('======================================');

      final result = await updateCartQtyUseCase.call(
        data: UpdateCartQty(lineId: lineId, qty: quantity),
      );

      result.fold(
        (failure) {
          debugPrint(
            'PRODUCT UPDATE CART FAILED: '
            '${failure.message}',
          );

          // Do not remove pending quantity on failure.
          // This allows another click to continue
          // from the latest UI quantity.

          // ignore: invalid_use_of_visible_for_testing_member
          emit(state.copyWith(errorMessage: failure.message));
        },
        (cartData) {
          debugPrint('PRODUCT UPDATE CART SUCCESS');

          // ========================================================
          // IMPORTANT
          // ========================================================
          //
          // Only remove pending quantity after successful API.
          //

          _pendingProductQuantities.remove(productId);

          _productQuantityTimers[productId]?.cancel();

          _productQuantityTimers.remove(productId);

          // ignore: invalid_use_of_visible_for_testing_member
          emit(state.copyWith(errorMessage: null));
        },
      );
    } catch (e) {
      debugPrint('PRODUCT UPDATE CART ERROR: $e');

      // ignore: invalid_use_of_visible_for_testing_member
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  // REMOVE PRODUCT FROM CART
  void _onRemoveProductFromCart(
    RemoveProductFromCart event,
    Emitter<ProductState> emit,
  ) {
    final updatedProducts = state.products.map((product) {
      if (product.id == event.productId) {
        product.alreadyInCart = false;
      }

      return product;
    }).toList();
    /*emit(state.copyWith(products: updatedProducts));*/
    final updatedQuantities = Map<int, int>.from(state.cartQuantities);
    updatedQuantities.remove(event.productId);

    final updatedLineIds = Map<int, int>.from(state.lineIds);
    updatedLineIds.remove(event.productId);

    emit(
      state.copyWith(
        products: updatedProducts,
        cartQuantities: updatedQuantities,
        lineIds: updatedLineIds,
      ),
    );
  }

  // SELECT CATEGORY
  void _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
    add(
      FetchProductsEvent(
        query: '',
        categoryId: event.category.id == 0 ? null : event.category.id,
      ),
    );
  }

  // FETCH CATEGORIES
  Future<void> _onFetchCategoriesEvent(
    FetchCategoriesEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isAddCartSuccess: false,
        errorMessage: null,
      ),
    );

    final result = await categoryUseCase.call();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            isAddCartSuccess: false,
            errorMessage: failure.message,
          ),
        );
      },
      (categories) {
        final allCategory = const CategoryModel(
          id: 0,
          name: AppStringsConstants.all,
        );

        emit(
          state.copyWith(
            isLoading: false,
            isAddCartSuccess: false,
            categories: [allCategory, ...categories],
            selectedCategory: allCategory,
          ),
        );

        add(FetchProductsEvent(query: '', categoryId: null));
      },
    );
  }

  // FETCH PRODUCTS
  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isAddCartSuccess: false,
        errorMessage: null,
      ),
    );

    final result = await productUseCase.call(
      data: ProductFilterData(
        name: event.query.toLowerCase().trim(),
        categoryId: event.categoryId,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            isAddCartSuccess: false,
            errorMessage: failure.message,
          ),
        );
      },
      (products) {
        emit(
          state.copyWith(
            isLoading: false,
            isAddCartSuccess: false,
            products: products,
          ),
        );
      },
    );
  }

  // ADD CART
  Future<void> _onAddCart(
    AddCartEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final productId = event.data.productId.toInt();

      emit(
        state.copyWith(
          loadingProductId: productId,
          errorMessage: null,
          isAddCartSuccess: false,
        ),
      );

      final result = await addCartUseCase.call(data: event.data);

      result.fold(
        (failure) {
          if (failure.message.isNotEmpty) {
            ToastHelper.error(failure.message);
          }

          emit(
            state.copyWith(
              loadingProductId: null,
              isAddCartSuccess: false,
              errorMessage: failure.message,
              // Preserve
              cartQuantities: state.cartQuantities,
              lineIds: state.lineIds,
            ),
          );
        },
        (cartData) {
          final updatedProducts = state.products.map((product) {
            if (product.id == productId) {
              product.alreadyInCart = true;
            }

            return product;
          }).toList();

          // Copy existing maps instead of creating empty maps.
          final Map<int, int> updatedQuantities = Map<int, int>.from(
            state.cartQuantities,
          );

          final Map<int, int> updatedLineIds = Map<int, int>.from(
            state.lineIds,
          );

          // Read latest cart response.
          for (final item in cartData.cartProducts) {
            final id = item.productId.toInt();

            updatedQuantities[id] = item.qty.toInt();

            updatedLineIds[id] = item.lineId.toInt();
          }

          // If API response does not contain quantity for some reason,
          // use the quantity that was just added.
          updatedQuantities.putIfAbsent(
            productId,
            () => event.data.productId.toInt(),
          );

          debugPrint('========== ADD CART SUCCESS ==========');

          debugPrint('Product ID: $productId');

          debugPrint('Updated Quantities: $updatedQuantities');

          debugPrint('Updated Line IDs: $updatedLineIds');

          emit(
            state.copyWith(
              errorMessage: null,
              loadingProductId: null,
              isAddCartSuccess: true,
              products: updatedProducts,
              cartQuantities: updatedQuantities,
              lineIds: updatedLineIds,
            ),
          );

          ToastHelper.success(AppStringsConstants.productCartMsg);
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingProductId: null,
          isAddCartSuccess: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
