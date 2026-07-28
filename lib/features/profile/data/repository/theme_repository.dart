import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/share_preference/share_pref_helper.dart';

class ThemeRepository {
  Future<void> saveTheme(ThemeMode mode) async {
    SharedPrefHelper.setString(AppStringsConstants.themeModeKey, mode.name);
  }

  Future<ThemeMode> loadTheme() async {
    final value = await SharedPrefHelper.getString(
      AppStringsConstants.themeModeKey,
    );

    switch (value) {
      case AppStringsConstants.light:
        return ThemeMode.light;
      case AppStringsConstants.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
