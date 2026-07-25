import 'package:equatable/equatable.dart';

class ResetPasswordState extends Equatable {
  final bool obscureNewPassword;
  final bool obscureConfirmPassword;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const ResetPasswordState({
    this.obscureNewPassword = true,
    this.obscureConfirmPassword = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  ResetPasswordState copyWith({
    bool? obscureNewPassword,
    bool? obscureConfirmPassword,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      obscureNewPassword: obscureNewPassword ?? this.obscureNewPassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    obscureNewPassword,
    obscureConfirmPassword,
    isLoading,
    isSuccess,
    errorMessage,
  ];
}