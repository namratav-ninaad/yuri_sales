import 'package:equatable/equatable.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';

class OrderState extends Equatable {
  final bool isLoading;
  final List<OrderModel> orders;
  final String? error;
  final OrderStatus? selectedStatus;

  const OrderState({
    this.isLoading = false,
    this.orders = const [],
    this.error,
    this.selectedStatus,
  });

  OrderState copyWith({
    bool? isLoading,
    List<OrderModel>? orders,
    String? error,
    OrderStatus? selectedStatus,
  }) {
    return OrderState(
      selectedStatus: selectedStatus ?? this.selectedStatus,
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: error,
    );
  }

  @override
  List<Object?> get props => [error, isLoading, orders, selectedStatus];
}
