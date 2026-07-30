import 'package:yuri_sale/features/invoice/domain/entities/search_invoice_data.dart';

abstract class InvoiceEvent {}

class ResetInvoiceEvent extends InvoiceEvent {}

class FetchInvoicesEvent extends InvoiceEvent {
  final SearchInvoiceData data;

  FetchInvoicesEvent({required this.data});
}
