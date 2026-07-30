import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/features/quote/domain/usecase/submit_rfq_usecase.dart';
import 'package:yuri_sale/features/quote/presentation/bloc/quote_event.dart';
import 'package:yuri_sale/features/quote/presentation/bloc/quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final SubmitRfqUseCase submitRfqUseCase;

  QuoteBloc({required this.submitRfqUseCase}) : super(const QuoteState()) {
    on<SubmitRfqEvent>(_submitRfq);
    on<ResetQuoteEvent>(_resetQuote);
  }

  Future<void> _resetQuote(ResetQuoteEvent event,
      Emitter<QuoteState> emit,) async {
    emit(QuoteState());
  }


  Future<void> _submitRfq(SubmitRfqEvent event,
      Emitter<QuoteState> emit,) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    final result = await submitRfqUseCase(data: event.data);

    result.fold(
          (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
          (response) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }
}
