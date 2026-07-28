import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final String otpValue;
  final String? otpError;
  final bool isLoading;
  final bool isSuccess;
  final int remainingSeconds;
  final bool canResend;
  final String? errorMessage;
  final bool isOTPSubmit;

  const OtpState({
    this.otpValue = '',
    this.otpError,
    this.isLoading = false,
    this.isSuccess = false,
    this.remainingSeconds = 30,
    this.canResend = false,
    this.errorMessage,
    this.isOTPSubmit = false,
  });

  OtpState copyWith({
    String? otpValue,
    String? otpError,
    bool? isLoading,
    bool? isOTPSubmit,
    bool? isSuccess,
    int? remainingSeconds,
    bool? canResend,
    String? errorMessage,
  }) {
    return OtpState(
      otpValue: otpValue ?? this.otpValue,
      otpError: otpError ?? this.otpError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      canResend: canResend ?? this.canResend,
      isOTPSubmit: isOTPSubmit ?? this.isOTPSubmit,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    otpValue,
    otpError,
    isLoading,
    isSuccess,
    remainingSeconds,
    canResend,
    errorMessage,
    isOTPSubmit,
  ];
}
