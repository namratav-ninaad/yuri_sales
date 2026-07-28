import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/features/product/domain/entities/product_filter_data.dart';
import 'package:yuri_sale/features/product/domain/usecases/add_cart_us.dart';
import 'package:yuri_sale/features/product/domain/usecases/product_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCase productUseCase;
  final AddCartUseCase addCartUseCase;

  ProductBloc({
    required this.productUseCase,
    required this.addCartUseCase,
  }) : super(const ProductState()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<AddCartEvent>(_onAddCart);
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await productUseCase.call(
      data: ProductFilterData(name: event.query.toLowerCase().trim()),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (products) => emit(state.copyWith(isLoading: false, products: products)),
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
        ),
      );

      final result = await addCartUseCase(data: event.data);

      result.fold(
        (failure) {
          if (failure.message.isNotEmpty) {
            ToastHelper.error(failure.message);
          }
          emit(
            state.copyWith(
              loadingProductId: null,
              errorMessage: failure.message,
            ),
          );
        },
        (cartData) {
          final updatedProducts = state.products.map((product) {
            if (product.id == event.data.productId) {
              product.already_in_cart = true;
            }
            return product;
          }).toList();

          emit(
            state.copyWith(
              errorMessage: null,
              loadingProductId: null,
              products: updatedProducts,
            ),
          );
          ToastHelper.success(AppStringsConstants.productCartMsg);
        },
      );
    } catch (e) {
      emit(state.copyWith(loadingProductId: null, errorMessage: e.toString()));
    }
  }
}
