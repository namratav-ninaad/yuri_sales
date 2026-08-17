import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/features/order/domain/usecases/fetch_order_uc.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_event.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final FetchOrdersUseCase fetchOrdersUseCase;

  OrderBloc({required this.fetchOrdersUseCase}) : super(OrderState()) {
    on<FetchOrdersEvent>(_onFetchOrders);
    on<ResetOrdersEvent>(_onResetOrders);
    on<OrderStatusFilterChanged>(_onOrderStatusFilterChanged);
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
}
