class SearchInvoiceData {
  final String invoiceNumber;
  final int? partnerId;

  SearchInvoiceData({required this.invoiceNumber, this.partnerId});

  Map<String, dynamic> toMap() {
    return {
      if (invoiceNumber.isNotEmpty) 'invoice_number': invoiceNumber,
      if (partnerId != null) 'partner_id': partnerId,
    };
  }
}
