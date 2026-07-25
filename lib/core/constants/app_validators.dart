import 'package:yuri_sale/core/constants/app_strings.dart';

class AppValidators {
  AppValidators._();

  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '${AppStringsConstants.pleaseEnter} $fieldName';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStringsConstants.pleaseEnterEmail;
    }

    const pattern = r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$';

    if (!RegExp(pattern).hasMatch(value)) {
      return AppStringsConstants.invalidEmail;
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStringsConstants.pleaseEnterPassword;
    }

    if (value.length < 6) {
      return AppStringsConstants.passwordMinLength;
    }

    return null;
  }


  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '${AppStringsConstants.pleaseEnter} ${AppStringsConstants.phoneNumber}';
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return AppStringsConstants.invalidPhone;
    }

    return null;
  }

  static String? confirmPassword(
      String? value,
      String password,
      ) {
    if (value == null || value.isEmpty) {
      return AppStringsConstants.pleaseConfirmPassword;
    }

    if (value != password) {
      return AppStringsConstants.passwordNotMatch;
    }

    return null;
  }
}