import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/delivery/data/model/delivery.dart';
import 'package:yuri_sale/features/invoice/data/model/invoice.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';

class DeliveryState extends Equatable {
  final bool isLoading;
  final List<DeliveryModel> deliveries;
  final String? error;

  const DeliveryState({
    this.isLoading = false,
    this.deliveries = const [],
    this.error,
  });

  DeliveryState copyWith({
    bool? isLoading,
    List<DeliveryModel>? deliveries,
    String? error,
  }) {
    return DeliveryState(
      isLoading: isLoading ?? this.isLoading,
      deliveries: deliveries ?? this.deliveries,
      error: error,
    );
  }

  @override
  List<Object?> get props => [error, isLoading, deliveries];
}
