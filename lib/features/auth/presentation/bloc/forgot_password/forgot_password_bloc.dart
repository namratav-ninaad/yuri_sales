import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/features/auth/domain/usecases/auth_usecase.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordBloc({required this.forgotPasswordUseCase})
    : super(const ForgotPasswordState()) {
    on<SendOtpSubmitted>(_sendOtp);
  }

  Future<void> _sendOtp(
    SendOtpSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    final result = await forgotPasswordUseCase(email: event.email);

    result.fold(
      (failure) {


        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (message) {
        emit(state.copyWith(isLoading: false, isSuccess: true));

      },
    );
  }
}
