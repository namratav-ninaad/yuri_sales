import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/features/delivery/domain/usecases/fetch_deliveries_uc.dart';
import 'package:yuri_sale/features/delivery/presentation/bloc/delivery_event.dart';
import 'package:yuri_sale/features/delivery/presentation/bloc/delivery_state.dart';
import 'package:yuri_sale/features/invoice/domain/usecases/fetach_invoice_uc.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_event.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_state.dart';
import 'package:yuri_sale/features/order/domain/usecases/fetch_order_uc.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_event.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final FetchDeliveriesUseCase fetchDeliveriesUseCase;

  DeliveryBloc({required this.fetchDeliveriesUseCase})
    : super(DeliveryState()) {
    on<FetchDeliveriesEvent>(_onFetchDeliveries);
    on<ResetDeliveryEvent>(_onResetDeliveryEvent);
  }

  Future<void> _onResetDeliveryEvent(
    ResetDeliveryEvent event,
    Emitter<DeliveryState> emit,
  ) async {
    emit(DeliveryState());
  }

  Future<void> _onFetchDeliveries(
    FetchDeliveriesEvent event,
    Emitter<DeliveryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final result = await fetchDeliveriesUseCase.call(data: event.data);

      result.fold(
        (failure) =>
            emit(state.copyWith(isLoading: false, error: failure.message)),
        (deliveries) =>
            emit(state.copyWith(isLoading: false, deliveries: deliveries)),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
