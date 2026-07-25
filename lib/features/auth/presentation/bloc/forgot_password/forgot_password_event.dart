import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class SendOtpSubmitted extends ForgotPasswordEvent {
  final String email;
  const SendOtpSubmitted(this.email);

  @override
  List<Object?> get props => [email];
}