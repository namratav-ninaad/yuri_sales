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

  const FetchCart({this.isFirstTimeLoading});

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
