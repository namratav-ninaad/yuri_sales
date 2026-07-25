import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/features/auth/domain/entities/verify_otp_submitted.dart';
import 'package:yuri_sale/features/auth/domain/usecases/auth_usecase.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  Timer? _timer;
  final VerifyOtpUseCase verifyOtpUseCase;

  OtpBloc({required this.verifyOtpUseCase}) : super(const OtpState()) {
    on<StartOtpTimer>(_startTimer);
    on<TickOtpTimer>(_tickTimer);
    on<ResendOtp>(_resendOtp);
    on<OtpChanged>(_onOtpChanged);
    on<VerifyOtpSubmitted>(_verifyOtp);
  }

  void _startTimer(StartOtpTimer event, Emitter<OtpState> emit) {
    _timer?.cancel();
    emit(
      state.copyWith(
        remainingSeconds: 30,
        canResend: false,
        errorMessage: null,
      ),
    );
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(TickOtpTimer());
    });
  }

  void _tickTimer(TickOtpTimer event, Emitter<OtpState> emit) {
    if (state.remainingSeconds > 1) {
      emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
    } else {
      _timer?.cancel();
      emit(state.copyWith(remainingSeconds: 0, canResend: true));
    }
  }

  void _resendOtp(ResendOtp event, Emitter<OtpState> emit) {
    add(StartOtpTimer());
  }

  void _onOtpChanged(OtpChanged event, Emitter<OtpState> emit) {
    emit(state.copyWith(otpValue: event.otp, otpError: null));
  }

  Future<void> _verifyOtp(
    VerifyOtpSubmitted event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    final result = await verifyOtpUseCase(
      data: VerifyOtpData(email: event.email, otp: event.otp),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (message) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
