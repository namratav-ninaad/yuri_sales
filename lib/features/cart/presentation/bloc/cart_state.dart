import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/cart/data/model/cart.dart';

class CartState extends Equatable {
  final bool isLoading;
  final bool isQuantityUpdated;
  final bool isItemRemoved;
  final CartModel? cartData;
  final String? errorMessage;
  final int cartItemCount;
  final Map<int, int> cartQuantities;
  final Map<int, int> lineIds;

  const CartState({
    this.errorMessage,
    this.isLoading = false,
    this.cartData,
    this.isQuantityUpdated = false,
    this.isItemRemoved = false,
    this.cartItemCount = 0,
    this.cartQuantities = const {},
    this.lineIds = const {},
  });

  CartState copyWith({
    bool? isLoading,
    CartModel? cartData,
    String? errorMessage,
    bool? isQuantityUpdated,
    bool? isItemRemoved,
    int? cartItemCount,
    Map<int, int>? cartQuantities,
    Map<int, int>? lineIds,

  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      cartData: cartData ?? this.cartData,
      errorMessage: errorMessage,
      isQuantityUpdated: isQuantityUpdated ?? this.isQuantityUpdated,
      isItemRemoved: isItemRemoved ?? this.isItemRemoved,
      cartItemCount: cartItemCount ?? this.cartItemCount,
      cartQuantities:
      cartQuantities ?? this.cartQuantities,

      lineIds:
      lineIds ?? this.lineIds,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    cartItemCount,
    cartData,
    errorMessage,
    isItemRemoved,
    isQuantityUpdated,
    cartItemCount,
    cartQuantities,
    lineIds
  ];
}
