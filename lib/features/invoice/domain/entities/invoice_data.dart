class InvoiceData {
  final int? partnerId;
  final bool isCustomer;

  InvoiceData({ this.partnerId, this.isCustomer = false});

  Map<String, dynamic> toMap() {
    return {
      if (partnerId != null) 'partner_id': partnerId,
    };
  }
}
