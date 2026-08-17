import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
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

  ProductBloc({
    required this.productUseCase,
    required this.addCartUseCase,
    required this.categoryUseCase,
  }) : super(const ProductState()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<FetchCategoriesEvent>(_onFetchCategoriesEvent);
    on<AddCartEvent>(_onAddCart);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  void _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
    add(FetchProductsEvent(query: '', categoryId: event.category.id));
  }

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
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isAddCartSuccess: false,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          isLoading: false,
          isAddCartSuccess: false,
          products: products,
        ),
      ),
    );
  }

  Future<void> _onAddCart(
    AddCartEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          loadingProductId: event.data.productId,
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
            ),
          );
        },
        (cartData) {
          final updatedProducts = state.products.map((product) {
            if (product.id == event.data.productId) {
              product.alreadyInCart = true;
            }
            return product;
          }).toList();

          emit(
            state.copyWith(
              errorMessage: null,
              loadingProductId: null,
              isAddCartSuccess: true,
              products: updatedProducts,
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
