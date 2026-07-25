import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class ToggleNewPasswordVisibility extends ResetPasswordEvent {}

class ToggleConfirmPasswordVisibility extends ResetPasswordEvent {}

class ResetPasswordSubmitted extends ResetPasswordEvent {
  final String newPassword;
  final String confirmPassword;
  final String email;

  const ResetPasswordSubmitted({
    required this.newPassword,
    required this.confirmPassword,
    required this.email,
  });

  @override
  List<Object?> get props => [newPassword, confirmPassword, email];
}
