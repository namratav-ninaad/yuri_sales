import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exception.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/auth/data/model/login_response_model.dart';
import 'package:yuri_sale/features/auth/domain/entities/login_data.dart';
import 'package:yuri_sale/features/auth/domain/entities/reset_password_submitted.dart';
import 'package:yuri_sale/features/auth/domain/entities/verify_otp_submitted.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({required LoginData data});

  Future<String> verifyOtp({required VerifyOtpData data});

  Future<String> forgotPassword({required String email});

  Future<String> resetPassword({required ResetPasswordData data});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<LoginModel> login({required LoginData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.loginURl,
        data: data.toMap(),
      );

      return CommonResponse<LoginModel>.fromJson(
        response.data,
        (json) => LoginModel.fromJson(json as Map<String, dynamic>),
      ).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> forgotPassword({required String email}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.forgotPasswordURl,
        data: {'email': email},
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> verifyOtp({required VerifyOtpData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.verifyOtpURl,
        data: data.toMap(),
      );
      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> resetPassword({required ResetPasswordData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.newPasswordURl,
        data: data.toMap(),
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
