import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/cart/data/model/cart.dart';

class CartState extends Equatable {
  final bool isLoading;
  final bool isQuantityUpdated;
  final bool isItemRemoved;
  final CartModel? cartData;
  final String? errorMessage;

  const CartState({
    this.errorMessage,
    this.isLoading = false,
    this.cartData,
    this.isQuantityUpdated = false,
    this.isItemRemoved = false,
  });

  CartState copyWith({
    bool? isLoading,
    CartModel? cartData,
    String? errorMessage,
    bool? isQuantityUpdated,
    bool? isItemRemoved,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      cartData: cartData ?? this.cartData,
      errorMessage: errorMessage,
      isQuantityUpdated: isQuantityUpdated ?? this.isQuantityUpdated,
      isItemRemoved: isItemRemoved ?? this.isItemRemoved,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    cartData,
    errorMessage,
    isItemRemoved,
    isQuantityUpdated,
  ];
}
