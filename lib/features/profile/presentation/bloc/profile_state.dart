import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yuri_sale/features/profile/data/model/profile_model.dart';

class ProfileState extends Equatable {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  final bool isOldPasswordVisible;
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final ProfileModel? profile;
  final File? selectedProfileImage;
  final ThemeMode themeMode;

  const ProfileState({
    this.oldPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isOldPasswordVisible = true,
    this.isNewPasswordVisible = true,
    this.isConfirmPasswordVisible = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.profile,
    this.themeMode = ThemeMode.system,
    this.selectedProfileImage,
  });

  ProfileState copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isOldPasswordVisible,
    bool? isNewPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isLoading,
    bool? isSuccess,
    String? error,
    ProfileModel? profile,
    File? selectedProfileImage,
    ThemeMode? themeMode,
  }) {
    return ProfileState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      selectedProfileImage: selectedProfileImage ?? this.selectedProfileImage,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isOldPasswordVisible: isOldPasswordVisible ?? this.isOldPasswordVisible,
      isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      profile: profile ?? this.profile,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    oldPassword,
    newPassword,
    confirmPassword,
    isOldPasswordVisible,
    isNewPasswordVisible,
    isConfirmPasswordVisible,
    isLoading,
    isSuccess,
    selectedProfileImage,
    error,
    profile,
    themeMode,
  ];
}
