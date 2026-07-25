import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/auth/data/model/login_response_model.dart';

class LoginState extends Equatable {
  final bool obscurePassword;
  final bool rememberMe;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final LoginModel? loginData;

  const LoginState({
    this.obscurePassword = true,
    this.rememberMe = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.loginData,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? obscurePassword,
    bool? rememberMe,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    LoginModel? loginData
  }) {
    return LoginState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      loginData: loginData?? this.loginData
    );
  }

  @override
  List<Object?> get props => [
    obscurePassword,
    rememberMe,
    isLoading,
    isSuccess,
    errorMessage,
    loginData
  ];
}