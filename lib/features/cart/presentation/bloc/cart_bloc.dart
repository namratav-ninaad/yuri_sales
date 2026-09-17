import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/features/cart/domain/entities/update_cart_qty.dart';
import 'package:yuri_sale/features/cart/domain/usecases/cart_us.dart';
import 'package:yuri_sale/features/cart/domain/usecases/remove_cart_uc.dart';
import 'package:yuri_sale/features/cart/domain/usecases/update_cart_qty_uc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUseCase cartUseCases;
  final UpdateCartQtyUseCase updateCartQtyUseCase;
  final RemoveCartUseCase removeCartUseCase;

  // PENDING QUANTITIES
  final Map<num, int> _pendingQuantities = {};

  // DEBOUNCE TIMERS
  final Map<num, Timer> _quantityTimers = {};

  CartBloc({
    required this.cartUseCases,
    required this.updateCartQtyUseCase,
    required this.removeCartUseCase,
  }) : super(const CartState()) {
    on<FetchCart>(_onFetchCart);

    on<IncreaseQuantity>(_onIncreaseQuantity);

    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<SetCartQuantity>(_onSetCartQuantity);
    on<RemoveCart>(_onRemoveCart);

    on<ResetCart>(_onResetCart);
  }

  // RESET
  Future<void> _onResetCart(ResetCart event, Emitter<CartState> emit) async {
    _cancelAllTimers();

    _pendingQuantities.clear();

    emit(const CartState());
  }

  // FETCH CART
  Future<void> _onFetchCart(FetchCart event, Emitter<CartState> emit) async {
    emit(
      state.copyWith(
        isLoading: event.isFirstTimeLoading ?? true,
        isQuantityUpdated: false,
        isItemRemoved: false,
      ),
    );

    try {
      final result = await cartUseCases.call();

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              isLoading: false,
              isQuantityUpdated: false,
              isItemRemoved: false,
              errorMessage: failure.message,
            ),
          );
        },
        (cartData) {
          // CREATE PRODUCT ID -> QUANTITY MAP
          final Map<int, int> cartQuantities = {};

          // CREATE PRODUCT ID -> LINE ID MAP
          final Map<int, int> lineIds = {};

          // CART DATA LOOP
          if (event.isProductQtySetData == true) {
            for (final cart in cartData.cartProducts) {
              final int productId = cart.productId.toInt();
              final int quantity = cart.qty.toInt();
              final int lineId = cart.lineId.toInt();

              cartQuantities[productId] = quantity;
              lineIds[productId] = lineId;

              debugPrint(
                'Cart Product -> '
                'productId: $productId | '
                'qty: $quantity | '
                'lineId: $lineId',
              );
            }
          }
          emit(
            state.copyWith(
              isLoading: false,
              isQuantityUpdated: false,
              isItemRemoved: false,
              cartData: cartData,
              cartItemCount: cartData.cartProducts.length,
              cartQuantities: cartQuantities,
              lineIds: lineIds,
              errorMessage: null,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isQuantityUpdated: false,
          isItemRemoved: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // SET CART QUANTITY (from text field)
  void _onSetCartQuantity(SetCartQuantity event, Emitter<CartState> emit) {
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

    // 1. Use lineId as key (same as Increase / Decrease)
    _pendingQuantities[lineId] = newQty;

    // 2. Optimistic update of the real cart list (this is what UI reads)

    _updateLocalQuantity(lineId: lineId, quantity: newQty, emit: emit);

    // Also keep cartQuantities map in sync (optional but useful)
    final quantities = Map<int, int>.from(state.cartQuantities);
    quantities[productId] = newQty;
    emit(state.copyWith(cartQuantities: quantities, errorMessage: null));

    debugPrint(
      'CART SET QTY -> productId: $productId | lineId: $lineId | newQty: $newQty',
    );

    // 3. Debounce API call
    _quantityTimers[lineId]?.cancel();

    _quantityTimers[lineId] = Timer(const Duration(milliseconds: 500), () {
      _callUpdateQuantityApi(lineId: lineId, quantity: newQty);
    });
  }

  // INCREASE QUANTITY
  Future<void> _onIncreaseQuantity(
    IncreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    final num lineId = event.data.lineId;

    // ----------------------------------------------------------
    // IMPORTANT
    // ----------------------------------------------------------
    //
    // If a pending quantity already exists,
    // ALWAYS use that quantity.
    //
    // Otherwise use the quantity from API/cart.
    //

    final int currentQty = _pendingQuantities[lineId] ?? event.data.qty.toInt();

    // Add exactly 1.
    final int newQty = currentQty + 1;

    // Save latest quantity.
    _pendingQuantities[lineId] = newQty;

    debugPrint(
      'INCREASE -> lineId: $lineId | '
      'qty: ${event.data.qty} | '
      'currentQty: $currentQty | '
      'newQty: $newQty',
    );

    // UPDATE UI IMMEDIATELY
    _updateLocalQuantity(lineId: lineId, quantity: newQty, emit: emit);

    // CANCEL PREVIOUS TIMER
    _quantityTimers[lineId]?.cancel();

    // START NEW 500MS TIMER
    _quantityTimers[lineId] = Timer(const Duration(milliseconds: 500), () {
      _callUpdateQuantityApi(lineId: lineId, quantity: newQty);
    });
  }

  // DECREASE QUANTITY
  Future<void> _onDecreaseQuantity(
    DecreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    final num lineId = event.data.lineId;

    final int currentQty = _pendingQuantities[lineId] ?? event.data.qty.toInt();

    // Minimum quantity = 1.
    if (currentQty <= 1) {
      return;
    }

    // Subtract exactly 1.
    final int newQty = currentQty - 1;

    // Save latest quantity.
    _pendingQuantities[lineId] = newQty;

    debugPrint(
      'DECREASE -> lineId: $lineId | '
      'qty: ${event.data.qty} | '
      'currentQty: $currentQty | '
      'newQty: $newQty',
    );

    // UPDATE UI IMMEDIATELY

    _updateLocalQuantity(lineId: lineId, quantity: newQty, emit: emit);

    // CANCEL PREVIOUS TIMER

    _quantityTimers[lineId]?.cancel();

    // START NEW 500MS TIMER

    _quantityTimers[lineId] = Timer(const Duration(milliseconds: 500), () {
      _callUpdateQuantityApi(lineId: lineId, quantity: newQty);
    });
  }

  // UPDATE LOCAL CART QUANTITY
  void _updateLocalQuantity({
    required num lineId,
    required int quantity,
    required Emitter<CartState> emit,
  }) {
    final cartData = state.cartData;

    if (cartData == null) {
      return;
    }

    final updatedProducts = cartData.cartProducts.map((item) {
      if (item.lineId == lineId) {
        return item.copyWith(qty: quantity);
      }

      return item;
    }).toList();

    final updatedCartData = cartData.copyWith(cartProducts: updatedProducts);

    emit(
      state.copyWith(
        cartData: updatedCartData,
        isQuantityUpdated: false,
        isItemRemoved: false,
        errorMessage: null,
      ),
    );
  }

  // UPDATE QUANTITY API
  Future<void> _callUpdateQuantityApi({
    required num lineId,
    required int quantity,
  }) async {
    try {
      debugPrint('======================================');
      debugPrint('UPDATE CART API');
      debugPrint('line_id: $lineId');
      debugPrint('qty: $quantity');
      debugPrint('======================================');

      final result = await updateCartQtyUseCase.call(
        data: UpdateCartQty(lineId: lineId.toInt(), qty: quantity),
      );

      result.fold(
        (failure) {
          // ignore: invalid_use_of_visible_for_testing_member
          emit(
            state.copyWith(
              errorMessage: failure.message,
              isItemRemoved: false,
              isQuantityUpdated: false,
            ),
          );
        },
        (cartData) {
          debugPrint('UPDATE CART API SUCCESS');

          // Clear pending only after success
          _pendingQuantities.remove(lineId);
          _quantityTimers[lineId]?.cancel();
          _quantityTimers.remove(lineId);

          // ignore: invalid_use_of_visible_for_testing_member
          emit(state.copyWith(isQuantityUpdated: true, isItemRemoved: false));

          // Refresh cart from server
          add(
            const FetchCart(
              isFirstTimeLoading: false,
              isProductQtySetData: true,
            ),
          );
        },
      );
    } catch (e) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isItemRemoved: false,
          isQuantityUpdated: false,
        ),
      );
    }
  }

  // REMOVE CART
  Future<void> _onRemoveCart(RemoveCart event, Emitter<CartState> emit) async {
    // Cancel quantity timer.
    _quantityTimers[event.lineId]?.cancel();

    _quantityTimers.remove(event.lineId);

    // Remove pending quantity.
    _pendingQuantities.remove(event.lineId);

    emit(state.copyWith(isItemRemoved: false, isQuantityUpdated: false));

    try {
      final result = await removeCartUseCase.call(lineId: event.lineId);

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              isItemRemoved: false,
              isQuantityUpdated: false,
              errorMessage: failure.message,
            ),
          );
        },
        (cartData) {
          emit(
            state.copyWith(
              isItemRemoved: true,
              isQuantityUpdated: false,
              errorMessage: null,
            ),
          );

          add(const FetchCart(isFirstTimeLoading: false));
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          isItemRemoved: false,
          isQuantityUpdated: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // CANCEL ALL TIMERS
  void _cancelAllTimers() {
    for (final timer in _quantityTimers.values) {
      timer.cancel();
    }

    _quantityTimers.clear();
  }

  // CLOSE
  @override
  Future<void> close() {
    _cancelAllTimers();

    _pendingQuantities.clear();

    return super.close();
  }
}
