import 'package:yuri_sale/core/enum/app_enum.dart';

class OrderData {
  final bool backButtonShow;
  final OrderStatus? status;
  final int? partnerId;

  OrderData({this.backButtonShow = false, this.status, this.partnerId});
}
