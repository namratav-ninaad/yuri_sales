import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/cart/domain/entities/update_cart_qty.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class ResetCart extends CartEvent {}

class FetchCart extends CartEvent {
  final bool? isFirstTimeLoading;
  final bool? isProductQtySetData;

  const FetchCart({this.isFirstTimeLoading, this.isProductQtySetData});

  @override
  List<Object?> get props => [isFirstTimeLoading];
}

class IncreaseQuantity extends CartEvent {
  final UpdateCartQty data;

  const IncreaseQuantity({required this.data});

  @override
  List<Object?> get props => [data];
}

class DecreaseQuantity extends CartEvent {
  final UpdateCartQty data;

  const DecreaseQuantity({required this.data});

  @override
  List<Object?> get props => [data];
}

class RemoveCart extends CartEvent {
  final int lineId;

  const RemoveCart({required this.lineId});

  @override
  List<Object?> get props => [lineId];
}

class SetCartQuantity extends CartEvent {
  final int productId;
  final int quantity;

  const SetCartQuantity({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productId, quantity];
}