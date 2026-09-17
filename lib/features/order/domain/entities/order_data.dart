import 'package:yuri_sale/core/enum/app_enum.dart';

class OrderData {
  final bool backButtonShow;
  final OrderStatus? status;
  final int? partnerId;
  final int? saleOrderId;

  OrderData({
    this.backButtonShow = false,
    this.status,
    this.partnerId,
    this.saleOrderId,
  });
}
