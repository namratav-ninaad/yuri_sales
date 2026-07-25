import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

class StartOtpTimer extends OtpEvent {}

class TickOtpTimer extends OtpEvent {}

class ResendOtp extends OtpEvent {}

class OtpChanged extends OtpEvent {
  final String otp;
  const OtpChanged(this.otp);
}

class VerifyOtpSubmitted extends OtpEvent {
  final String otp;
  final String email;
  const VerifyOtpSubmitted(this.otp, this.email);
}