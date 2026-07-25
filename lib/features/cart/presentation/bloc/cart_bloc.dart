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

  CartBloc({
    required this.cartUseCases,
    required this.updateCartQtyUseCase,
    required this.removeCartUseCase,
  }) : super(const CartState()) {
    on<FetchCart>(_onFetchCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<RemoveCart>(_onRemoveCart);
  }

  Future<void> _onFetchCart(FetchCart event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: event.isFirstTimeLoading ?? true));
    try {
      final result = await cartUseCases.call();

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, errorMessage: failure.message));
        },
        (cartData) {
          emit(state.copyWith(isLoading: false, cartData: cartData));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onIncreaseQuantity(
    IncreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(isQuantityUpdated: false));
    try {
      final result = await updateCartQtyUseCase.call(data: event.data);

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              errorMessage: failure.message,
              isQuantityUpdated: false,
            ),
          );
        },
        (cartData) {
          emit(state.copyWith(isQuantityUpdated: true));
        },
      );
      add(FetchCart(isFirstTimeLoading: false));
    } catch (e) {
      emit(
        state.copyWith(isQuantityUpdated: false, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onDecreaseQuantity(
    DecreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(isQuantityUpdated: false));
    try {
      final result = await updateCartQtyUseCase.call(data: event.data);

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              errorMessage: failure.message,
              isQuantityUpdated: false,
            ),
          );
        },
        (cartData) {
          emit(state.copyWith(isQuantityUpdated: true));
        },
      );

      add(FetchCart(isFirstTimeLoading: false));
    } catch (e) {
      emit(
        state.copyWith(isQuantityUpdated: false, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onRemoveCart(RemoveCart event, Emitter<CartState> emit) async {
    emit(state.copyWith(isItemRemoved: false));
    try {
      var result = await removeCartUseCase.call(lineId: event.lineId);

      result.fold(
        (failure) {
          emit(
            state.copyWith(isItemRemoved: false, errorMessage: failure.message),
          );
        },
        (cartData) {
          emit(state.copyWith(isItemRemoved: true));
        },
      );

      add(FetchCart(isFirstTimeLoading: false));
    } catch (e) {
      emit(state.copyWith(isItemRemoved: false, errorMessage: e.toString()));
    }
  }
}
