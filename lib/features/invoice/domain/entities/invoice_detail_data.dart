import 'package:yuri_sale/features/invoice/data/model/invoice.dart';

class InvoiceDetailData {
  final InvoiceModel invoiceModel;
  final bool isCustomer;

  InvoiceDetailData({this.isCustomer = false, required this.invoiceModel});
}
