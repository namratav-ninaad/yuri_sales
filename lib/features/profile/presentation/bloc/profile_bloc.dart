import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/share_preference/share_pref_helper.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/features/profile/data/repository/theme_repository.dart';
import 'package:yuri_sale/features/profile/domain/entities/change_password_data.dart';
import 'package:yuri_sale/features/profile/domain/usecases/change_password_uc.dart';
import 'package:yuri_sale/features/profile/domain/usecases/delete_account_uc.dart';
import 'package:yuri_sale/features/profile/domain/usecases/get_profile_uc.dart';
import 'package:yuri_sale/features/profile/domain/usecases/logout_uc.dart';
import 'package:yuri_sale/features/profile/domain/usecases/update_profile_uc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ChangePasswordUseCase changePasswordUseCase;
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final LogoutUseCase logoutUseCase;
  final ThemeRepository repository;
  final DeleteAccountUseCase deleteAccountUseCase;

  ProfileBloc({
    required this.changePasswordUseCase,
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.logoutUseCase,
    required this.repository,
    required this.deleteAccountUseCase,
  }) : super(const ProfileState()) {
    on<OldPasswordChanged>(_onOldPasswordChanged);
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<ToggleOldPasswordVisibility>(_onToggleOldPasswordVisibility);
    on<ToggleNewPasswordVisibility>(_onToggleNewPasswordVisibility);
    on<ToggleConfirmPasswordVisibility>(_onToggleConfirmPasswordVisibility);
    on<SubmitChangePassword>(_onSubmitChangePassword);
    on<InitChangePassword>(_onInitChangePassword);
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<PickProfileImageEvent>(_onPickProfileImage);
    on<LogoutEvent>(_onLogout);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<LoadThemeEvent>(_load);
    on<ChangeThemeEvent>(_change);
  }

  Future<void> _load(LoadThemeEvent event, Emitter<ProfileState> emit) async {
    final theme = await repository.loadTheme();
    emit(state.copyWith(themeMode: theme));
  }

  Future<void> _change(
    ChangeThemeEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await repository.saveTheme(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  void _onInitChangePassword(
    InitChangePassword event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      state.copyWith(
        oldPassword: '',
        newPassword: '',
        confirmPassword: '',
        isOldPasswordVisible: true,
        isNewPasswordVisible: true,
        isConfirmPasswordVisible: true,
        error: null,
        isSuccess: false,
        isLoading: false,
      ),
    );
  }

  void _onPickProfileImage(
    PickProfileImageEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      state.copyWith(
        selectedProfileImage: event.image,
        error: null,
        isSuccess: false,
      ),
    );
  }

  void _onOldPasswordChanged(
    OldPasswordChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(oldPassword: event.oldPassword, error: null));
  }

  void _onNewPasswordChanged(
    NewPasswordChanged event,
    Emitter<ProfileState> emit,
  ) {
    final newState = state.copyWith(
      newPassword: event.newPassword,
      error: null,
    );
    emit(newState);
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(confirmPassword: event.confirmPassword, error: null));
  }

  void _onToggleOldPasswordVisibility(
    ToggleOldPasswordVisibility event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      state.copyWith(
        isOldPasswordVisible: !state.isOldPasswordVisible,
        error: null,
      ),
    );
  }

  void _onToggleNewPasswordVisibility(
    ToggleNewPasswordVisibility event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      state.copyWith(
        isNewPasswordVisible: !state.isNewPasswordVisible,
        error: null,
      ),
    );
  }

  void _onToggleConfirmPasswordVisibility(
    ToggleConfirmPasswordVisibility event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
        error: null,
      ),
    );
  }

  Future<void> _onSubmitChangePassword(
    SubmitChangePassword event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, isSuccess: false, error: null));

      final result = await changePasswordUseCase(
        data: ChangePasswordData(
          oldPassword: state.oldPassword,
          newPassword: state.newPassword,
          confirmPassword: state.confirmPassword,
        ),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, error: failure.message));
        },
        (message) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, isSuccess: false));

    try {
      final result = await getProfileUseCase.call();
      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, error: failure.message));
        },
        (profile) {
          emit(
            state.copyWith(isLoading: false, profile: profile, isSuccess: true),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, isSuccess: false, error: null));

      final result = await updateProfileUseCase(data: event.data);

      result.fold(
        (failure) {
          if (failure.message.isNotEmpty) {
            ToastHelper.error(failure.message);
          }
          emit(state.copyWith(isLoading: false, error: failure.message));
        },
        (message) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
          add(GetProfileEvent());
          ToastHelper.success(AppStringsConstants.profileUpdateMsg);
          AppRoutes.pop();
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await logoutUseCase.call();
      result.fold(
        (failure) {
          if (failure.message.isNotEmpty) {
            ToastHelper.error(failure.message);
          }
          emit(state.copyWith(isLoading: false, error: failure.message));
        },
        (message) async {
          emit(state.copyWith(isLoading: false));
          await SharedPrefHelper.remove(AppStringsConstants.loginResponse);
          await SharedPrefHelper.remove(AppStringsConstants.sessionId);
          AppRoutes.pushReplacementNamed(RouteNames.login);
          ToastHelper.success(AppStringsConstants.logoutMsg);
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onDeleteAccount(
    DeleteAccountEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await deleteAccountUseCase.call(userId: event.userId);
      result.fold(
        (failure) {
          if (failure.message.isNotEmpty) {
            ToastHelper.error(failure.message);
          }
          emit(state.copyWith(isLoading: false, error: failure.message));
        },
        (message) async {
          emit(state.copyWith(isLoading: false));
          await SharedPrefHelper.clearAll();
          AppRoutes.pushReplacementNamed(RouteNames.login);
          ToastHelper.success(AppStringsConstants.deleteAccountMsg);
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
