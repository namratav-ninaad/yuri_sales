import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';

class ToastHelper {
  static void success(String message) {
    _showToast(
      message: message,
      backgroundColor: AppColorsConstants.green,
    );
  }

  static void error(String message) {
    _showToast(
      message: message,
      backgroundColor: AppColorsConstants.red,
    );
  }

  static void warning(String message) {
    _showToast(
      message: message,
      backgroundColor:AppColorsConstants.orange,
    );
  }

  static void info(String message) {
    _showToast(
      message: message,
      backgroundColor: Colors.blue,
    );
  }

  static void _showToast({
    required String message,
    required Color backgroundColor,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: AppColorsConstants.white,
      fontSize: AppSizes.f16,
    );
  }
}