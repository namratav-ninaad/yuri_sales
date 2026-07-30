import 'package:yuri_sale/features/order/domain/entities/search_order_data.dart';

abstract class OrderEvent {}

class ResetOrdersEvent extends OrderEvent {}

class FetchOrdersEvent extends OrderEvent {
  final SearchOrderData data;
  FetchOrdersEvent({required this.data});
}
