import 'package:yuri_sale/core/enum/app_enum.dart';

class SearchOrderData {
  final OrderStatus? status;
  final String name;
  final int? partnerId;
  final int? saleUserId;

  const SearchOrderData({
    this.status,
    this.name = '',
    this.partnerId,
    this.saleUserId,
  });

  Map<String, dynamic> toMap() {
    return {
      if (status != null) 'status': status!.apiValue,
      if (name.isNotEmpty) 'name': name,
      if (partnerId != null) 'partner_id': partnerId,
      if (saleUserId != null) 'sale_user_id': saleUserId,
    };
  }
}
