import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exception.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/delivery/data/model/delivery.dart';
import 'package:yuri_sale/features/delivery/domain/entities/search_delivery_data.dart';

abstract class DeliveryRemoteDataSource {
  Future<List<DeliveryModel>> fetchDeliveries({
    required SearchDeliveryData data,
  });
}

class DeliveryRemoteDataSourceImpl implements DeliveryRemoteDataSource {
  final Dio dio;

  DeliveryRemoteDataSourceImpl(this.dio);

  @override
  Future<List<DeliveryModel>> fetchDeliveries({
    required SearchDeliveryData data,
  }) async {
    try {
      final res = await dio.get(
        AppStringsConstants.deliveriesURl,
        queryParameters: data.toMap(),
      );

      return CommonResponse<List<DeliveryModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['deliveries'] != null) {
          return (json['deliveries'] as List)
              .map((e) => DeliveryModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
