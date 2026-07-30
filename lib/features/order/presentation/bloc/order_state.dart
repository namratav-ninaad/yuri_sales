import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';

class OrderState extends Equatable {
  final bool isLoading;
  final List<OrderModel> orders;
  final String? error;

  const OrderState({
    this.isLoading = false,
    this.orders = const [],
    this.error,
  });

  OrderState copyWith({
    bool? isLoading,
    List<OrderModel>? orders,
    String? error,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: error,
    );
  }

  @override
  List<Object?> get props => [error, isLoading, orders];
}
