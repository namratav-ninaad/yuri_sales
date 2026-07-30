import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/invoice/data/model/invoice.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';

class InvoiceState extends Equatable {
  final bool isLoading;
  final List<InvoiceModel> invoices;
  final String? error;

  const InvoiceState({
    this.isLoading = false,
    this.invoices = const [],
    this.error,
  });

  InvoiceState copyWith({
    bool? isLoading,
    List<InvoiceModel>? invoices,
    String? error,
  }) {
    return InvoiceState(
      isLoading: isLoading ?? this.isLoading,
      invoices: invoices ?? this.invoices,
      error: error,
    );
  }

  @override
  List<Object?> get props => [error, isLoading, invoices];
}
