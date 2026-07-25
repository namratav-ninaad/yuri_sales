import 'package:bloc/bloc.dart';
import 'package:yuri_sale/features/customer/domain/entities/customer_filter_data.dart';
import 'package:yuri_sale/features/customer/domain/usecases/customer_uc.dart';

import 'customer_event.dart';
import 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerUseCase customerUseCase;

  CustomerBloc({required this.customerUseCase}) : super(CustomerState()) {
    on<FetchCustomerEvent>(_onFetchCustomer);
  }

  Future<void> _onFetchCustomer(
    FetchCustomerEvent event,
    Emitter<CustomerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await customerUseCase.call(
      data: CustomerFilterData(name: event.query.toLowerCase().trim()),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (customers) =>
          emit(state.copyWith(isLoading: false, customers: customers)),
    );
  }
}
