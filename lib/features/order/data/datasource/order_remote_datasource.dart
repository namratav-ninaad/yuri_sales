import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exeptions.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> fetchOrders({required String status});
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSourceImpl(this.dio);

  @override
  Future<List<OrderModel>> fetchOrders({required String status}) async {
    try {
      final res = await dio.get(
        AppStringsConstants.ordersURl,
        queryParameters: status.isNotEmpty ? {'status': status} : null,
      );

      return CommonResponse<List<OrderModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['sale_orders'] != null) {
          return (json['sale_orders'] as List)
              .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
