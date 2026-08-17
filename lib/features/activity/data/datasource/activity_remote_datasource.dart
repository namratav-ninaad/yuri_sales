import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exception.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/activity/data/model/activity.dart';
import 'package:yuri_sale/features/activity/data/model/user.dart';
import 'package:yuri_sale/features/activity/domain/entities/mark_done_data.dart';
import 'package:yuri_sale/features/activity/domain/entities/schedule_activity_data.dart';

abstract class ActivityRemoteDataSource {
  Future<ActivityModel> fetchActivity({required int partnerId});

  Future<List<UserModel>> fetchUsers();

  Future<ActivityItemModel> createActivity({required ScheduleActivityData data});

  Future<String> updateActivity({required ScheduleActivityData data});

  Future<String> deleteActivity({required int activityId});

  Future<String> markDoneActivity({required MarkDoneData data});
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  final Dio dio;

  ActivityRemoteDataSourceImpl(this.dio);

  @override
  Future<ActivityModel> fetchActivity({required int partnerId}) async {
    try {
      final response = await dio.get(
        AppStringsConstants.activityURl,
        queryParameters: {'partner_id': partnerId},
      );

      return CommonResponse<ActivityModel>.fromJson(
        response.data,
        (json) => ActivityModel.fromJson(json as Map<String, dynamic>),
      ).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await dio.get(AppStringsConstants.userURl);

      return CommonResponse<List<UserModel>>.fromJson(
        response.data,
        (json) => (json as List)
            .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      ).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<ActivityItemModel> createActivity({required ScheduleActivityData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.activityURl,
        data: data.toJson(),
      );

      return
        CommonResponse<ActivityItemModel>.fromJson(
          response.data,
              (json) => ActivityItemModel.fromJson(json as Map<String, dynamic>),
        ).data;

        // CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> updateActivity({required ScheduleActivityData data}) async {
    try {
      final response = await dio.put(
        AppStringsConstants.activityURl,
        data: data.toJson(),
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> markDoneActivity({required MarkDoneData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.markDoneActivityURl,
        data: data.toJson(),
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> deleteActivity({required int activityId}) async {
    try {
      final response = await dio.delete(
        AppStringsConstants.activityURl,
        data: {'activity_id': activityId},
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
