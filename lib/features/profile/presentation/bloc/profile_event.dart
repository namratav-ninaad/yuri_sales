import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/profile/domain/entities/update_profile_data.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class OldPasswordChanged extends ProfileEvent {
  final String oldPassword;

  const OldPasswordChanged(this.oldPassword);
}

class NewPasswordChanged extends ProfileEvent {
  final String newPassword;

  const NewPasswordChanged(this.newPassword);
}

class ConfirmPasswordChanged extends ProfileEvent {
  final String confirmPassword;

  const ConfirmPasswordChanged(this.confirmPassword);
}

class ToggleOldPasswordVisibility extends ProfileEvent {}

class ToggleNewPasswordVisibility extends ProfileEvent {}

class ToggleConfirmPasswordVisibility extends ProfileEvent {}

class SubmitChangePassword extends ProfileEvent {}

class InitChangePassword extends ProfileEvent {}

class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent();
}

class PickProfileImageEvent extends ProfileEvent {
  final File image;

  const PickProfileImageEvent(this.image);
}

class UpdateProfileEvent extends ProfileEvent {
  final UpdateProfileData data;

  const UpdateProfileEvent(this.data);
}

class LogoutEvent extends ProfileEvent {}
