class SearchInvoiceData {
  final String invoiceNumber;
  final int? partnerId;
  final bool? outStanding;

  SearchInvoiceData({
    this.outStanding,
    required this.invoiceNumber,
    this.partnerId,
  });

  Map<String, dynamic> toMap() {
    return {
      if (invoiceNumber.isNotEmpty) 'invoice_number': invoiceNumber,
      if (partnerId != null) 'partner_id': partnerId,
      if (outStanding != null) 'outstanding': outStanding,
    };
  }
}
