import 'package:yuri_sale/features/delivery/domain/entities/search_delivery_data.dart';

abstract class DeliveryEvent {}

class ResetDeliveryEvent extends DeliveryEvent {}

class FetchDeliveriesEvent extends DeliveryEvent {
  final SearchDeliveryData data;

  FetchDeliveriesEvent({required this.data});
}
