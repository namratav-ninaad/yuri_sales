import 'package:yuri_sale/core/enum/app_enum.dart';

class SearchOrderData {
  final OrderStatus? status;
  final String name;
  final int? partnerId;

  const SearchOrderData({
    this.status,
    this.name = '',
    this.partnerId,
  });

  Map<String, dynamic> toMap() {
    return {
      if (status != null) 'status': status!.apiValue,
      if (name.isNotEmpty) 'name': name,
      if (partnerId != null) 'partner_id': partnerId,
    };
  }
}