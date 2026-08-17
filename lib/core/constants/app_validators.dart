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

    // Minimum 8 characters
    if (value.length < 8) {
      return AppStringsConstants.min8Characters;
    }

    // At least 1 uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return AppStringsConstants.atoZUpperCharacters;
    }

    // At least 1 lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return AppStringsConstants.aTozLowerCharacters;
    }

    // At least 1 number OR special character
    if (!RegExp(r'[0-9!@#$%^&*(),.?":{}|<>_\-+=/\\[\]]').hasMatch(value)) {
      return AppStringsConstants.specialCharacters;
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return '${AppStringsConstants.pleaseEnter} ${AppStringsConstants.phoneNumber}';
    }

    // Optional: check valid prefix
    if (!RegExp(r'^(50|52|53|54|55|56|57|58)').hasMatch(value)) {
      return AppStringsConstants.invalidPhone;
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppStringsConstants.pleaseConfirmPassword;
    }

    if (value != password) {
      return AppStringsConstants.passwordNotMatch;
    }

    return null;
  }
}
