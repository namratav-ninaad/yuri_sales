import 'dart:typed_data';

import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/features/order/domain/entities/search_order_data.dart';

abstract class OrderEvent {}

class ResetOrdersEvent extends OrderEvent {}

class FetchOrdersEvent extends OrderEvent {
  final SearchOrderData data;
  FetchOrdersEvent({required this.data});
}

class OrderStatusFilterChanged extends OrderEvent {
  final OrderStatus? status;

  OrderStatusFilterChanged(this.status);
}
class FetchQuotationPdfEvent extends OrderEvent {
  final String orderNumber;
  final String pdfUrl;

  FetchQuotationPdfEvent({
    required this.orderNumber,
    required this.pdfUrl,
  });

  List<Object?> get props => [
    orderNumber,
    pdfUrl,
  ];
}

class ShareQuotationPdfEvent extends OrderEvent {
  final Uint8List pdfBytes;
  final String orderNumber;

  ShareQuotationPdfEvent({
    required this.pdfBytes,
    required this.orderNumber,
  });

  List<Object?> get props => [
    pdfBytes,
    orderNumber,
  ];
}