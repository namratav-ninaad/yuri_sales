import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/features/invoice/domain/usecases/fetach_invoice_uc.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_event.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final FetchInvoicesUseCase fetchInvoiceUseCase;

  InvoiceBloc({required this.fetchInvoiceUseCase}) : super(InvoiceState()) {
    on<FetchInvoicesEvent>(_onFetchInvoices);
    on<ResetInvoiceEvent>(_onResetInvoice);
  }

  Future<void> _onResetInvoice(
    ResetInvoiceEvent event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(InvoiceState());
  }

  Future<void> _onFetchInvoices(
    FetchInvoicesEvent event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final result = await fetchInvoiceUseCase.call(data: event.data);

      result.fold(
        (failure) =>
            emit(state.copyWith(isLoading: false, error: failure.message)),
        (invoices) => emit(state.copyWith(isLoading: false, invoices: invoices)),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
