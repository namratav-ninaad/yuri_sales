import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exception.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/dashboard/data/model/dashboard.dart';
import 'package:yuri_sale/features/dashboard/domain/entities/dashboard_data.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardModel> fetchDashboard({required DashboardData data});
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSourceImpl(this.dio);

  @override
  Future<DashboardModel> fetchDashboard({required DashboardData data}) async {
    try {
      final response = await dio.get(
        AppStringsConstants.salesDashboardURl,
        queryParameters: data.toQuery(),
      );

      return CommonResponse<DashboardModel>.fromJson(
        response.data,
        (json) => DashboardModel.fromJson(json as Map<String, dynamic>),
      ).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
