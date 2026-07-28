import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';

extension ThemeColors on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get white =>
      isDark ? AppColorsConstants.black : AppColorsConstants.white;

  Color get black =>
      isDark ? AppColorsConstants.white : AppColorsConstants.black;

  Color get greyC8 =>
      isDark ? AppColorsConstants.grey61 : AppColorsConstants.greyC8;

  Color get grey89 =>
      isDark ? AppColorsConstants.greyBD : AppColorsConstants.grey89;

  Color get greyA3 =>
      isDark ? AppColorsConstants.grey9E : AppColorsConstants.greyA3;

  Color get greyF2 =>
      isDark ? AppColorsConstants.grey2C : AppColorsConstants.greyF2;

  Color get primaryRedColor => AppColorsConstants.primaryRedColor;
}
