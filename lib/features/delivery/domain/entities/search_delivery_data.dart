class SearchDeliveryData {
  final String deliveryName;
  final int? partnerId;

  SearchDeliveryData({required this.deliveryName, this.partnerId});

  Map<String, dynamic> toMap() {
    return {
      if (deliveryName.isNotEmpty) 'delivery_name': deliveryName,
      if (partnerId != null) 'partner_id': partnerId,
    };
  }
}