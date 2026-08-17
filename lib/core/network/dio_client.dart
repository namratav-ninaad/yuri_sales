import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/share_preference/share_pref_helper.dart';
import 'package:yuri_sale/features/auth/data/model/login_response_model.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppStringsConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(SessionInterceptor());

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (object) {
          debugPrint(object.toString());
        },
      ),
    );
  }
}

class SessionInterceptor extends Interceptor {
  /// Add session_id to every request
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final result = await Connectivity().checkConnectivity();
    final loginJson = await SharedPrefHelper.getString(
      AppStringsConstants.loginResponse,
    );
    final sessionId = await SharedPrefHelper.getString(
      AppStringsConstants.sessionId,
    );
    if (loginJson != null && loginJson.isNotEmpty) {
      final loginData = LoginModel.fromJson(jsonDecode(loginJson));

      if (sessionId != null && sessionId.isNotEmpty) {
        options.headers['Cookie'] = sessionId;
      }
      if (loginData.accessToken.isNotEmpty) {
        options.headers['api-key'] = loginData.accessToken;
      }
    }

    if (result.contains(ConnectivityResult.none)) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'No internet connection',
        ),
      );
    }
    handler.next(options);
  }

  /// Save latest session_id from response
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final cookies = response.headers['set-cookie'];

    if (cookies != null && cookies.isNotEmpty) {
      try {
        final sessionCookie = cookies.firstWhere(
          (cookie) => cookie.contains('session_id'),
        );

        final sessionId = sessionCookie.split(';').first;

        await SharedPrefHelper.setString(
          AppStringsConstants.sessionId,
          sessionId,
        );
      } catch (e) {
        log('Session Error : $e');
      }
    }

    handler.next(response);
  }

  /// Handle expired session
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await SharedPrefHelper.clearAll();

      // Navigate to Login Screen if needed
      AppRoutes.pushReplacementNamed(RouteNames.login);
    }

    handler.next(err);
  }
}
