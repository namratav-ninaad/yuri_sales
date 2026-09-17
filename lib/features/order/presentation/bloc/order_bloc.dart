import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/features/order/domain/usecases/fetch_order_uc.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_event.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final FetchOrdersUseCase fetchOrdersUseCase;
  final FetchQuotationPdfUseCase fetchQuotationPdfUseCase;
  final ShareQuotationPdfUseCase shareQuotationPdfUseCase;

  OrderBloc({
    required this.fetchOrdersUseCase,
    required this.fetchQuotationPdfUseCase,
    required this.shareQuotationPdfUseCase,
  }) : super(OrderState()) {
    on<FetchOrdersEvent>(_onFetchOrders);
    on<ResetOrdersEvent>(_onResetOrders);
    on<OrderStatusFilterChanged>(_onOrderStatusFilterChanged);
    on<FetchQuotationPdfEvent>(_onFetchQuotationPdf);
    on<ShareQuotationPdfEvent>(_onShareQuotationPdf);
  }

  Future<void> _onOrderStatusFilterChanged(
    OrderStatusFilterChanged event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(selectedStatus: event.status));
  }

  Future<void> _onResetOrders(
    ResetOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderState());
  }

  Future<void> _onFetchOrders(
    FetchOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final result = await fetchOrdersUseCase.call(data: event.data);

      result.fold(
        (failure) =>
            emit(state.copyWith(isLoading: false, error: failure.message)),
        (orders) => emit(state.copyWith(isLoading: false, orders: orders)),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onFetchQuotationPdf(
    FetchQuotationPdfEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(
      state.copyWith(
        isPdfLoading: true,
        pdfErrorMessage: null,
        clearPdfError: true,
      ),
    );

    try {
      final result = await fetchQuotationPdfUseCase.call(pdfUrl: event.pdfUrl);

      result.fold(
        (failure) => emit(
          state.copyWith(isPdfLoading: false, pdfErrorMessage: failure.message),
        ),
        (bytes) => emit(
          state.copyWith(
            isPdfLoading: false,
            quotationPdfBytes: bytes,
            quotationPdfOrderNumber: event.orderNumber,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isPdfLoading: false, pdfErrorMessage: e.toString()));
    }
  }

  Future<void> _onShareQuotationPdf(
    ShareQuotationPdfEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isPdfSharing: true, clearSharePdfError: true));

    try {
      await shareQuotationPdfUseCase.call(
        pdfBytes: event.pdfBytes,
        orderNumber: event.orderNumber,
      );
      emit(state.copyWith(isPdfSharing: false));
    } catch (e) {
      emit(
        state.copyWith(isPdfSharing: false, sharePdfErrorMessage: e.toString()),
      );
    }
  }
}
