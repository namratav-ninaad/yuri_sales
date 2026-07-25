import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/share_preference/share_pref_helper.dart';
import 'package:yuri_sale/features/auth/domain/entities/login_data.dart';
import 'package:yuri_sale/features/auth/domain/usecases/auth_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(const LoginState()) {
    on<LoginSubmitted>(_login);
    on<TogglePasswordVisibility>(_togglePassword);
    on<ToggleRememberMe>(_toggleRememberMe);
    on<ResetLoginData>(_onResetLoginData);
  }

  void _onResetLoginData(ResetLoginData event, Emitter<LoginState> emit) {
    emit(LoginState());
  }

  Future<void> _login(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    final result = await loginUseCase(
      data: LoginData(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (loginData) async {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            loginData: loginData,
          ),
        );
        await SharedPrefHelper.setString(
          AppStringsConstants.accessToken,
          loginData.accessToken,
        );
        /* await SharedPrefHelper.setString(
          AppStringsConstants.sessionId,
          loginData.sessionId,
        );*/
      },
    );
  }

  void _togglePassword(
    TogglePasswordVisibility event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        obscurePassword: !state.obscurePassword,
        errorMessage: null,
      ),
    );
  }

  void _toggleRememberMe(ToggleRememberMe event, Emitter<LoginState> emit) {
    emit(state.copyWith(rememberMe: event.value, errorMessage: null));
  }
}
