class SearchOrderData {
  final String status;
  final String name;
  final int? partnerId;

  SearchOrderData({this.status = '', required this.name, this.partnerId});

  Map<String, dynamic> toMap() {
    return {
      if (status.isNotEmpty) 'status': status,
      'name': name,
      if (partnerId != null) 'partner_id': partnerId,
    };
  }
}
