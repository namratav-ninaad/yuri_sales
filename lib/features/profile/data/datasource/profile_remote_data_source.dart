import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exeptions.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/profile/data/model/profile_model.dart';
import 'package:yuri_sale/features/profile/domain/entities/change_password_data.dart';
import 'package:yuri_sale/features/profile/domain/entities/update_profile_data.dart';

abstract class ProfileRemoteDataSource {
  Future<String> changePassword({required ChangePasswordData data});

  Future<String> updateProfile({required UpdateProfileData data});

  Future<String> logout();

  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl(this.dio);

  @override
  Future<String> changePassword({required ChangePasswordData data}) async {
    try {
      final response = await dio.put(
        AppStringsConstants.changePasswordURl,
        data: data.toMap(),
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> updateProfile({required UpdateProfileData data}) async {
    try {
      final formData = await data.toMap();

      final response = await dio.put(
        AppStringsConstants.updateProfileURl,
        data: formData,
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> logout() async {
    try {
      final response = await dio.post(AppStringsConstants.logoutURl);

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await dio.get(AppStringsConstants.getProfileURl);

      return CommonResponse<ProfileModel>.fromJson(
        response.data,
        (json) => ProfileModel.fromJson(json as Map<String, dynamic>),
      ).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
