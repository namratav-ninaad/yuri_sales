import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exeptions.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/product/data/model/product_model.dart';
import 'package:yuri_sale/features/product/domain/entities/add_cart_data.dart';
import 'package:yuri_sale/features/product/domain/entities/product_filter_data.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts({required ProductFilterData data});

  Future<String> addCart({required AddCartData data});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> fetchProducts({
    required ProductFilterData data,
  }) async {
    try {
      final res = await dio.get(
        AppStringsConstants.productsURl,
        queryParameters: data.toQuery(),
      );

      return CommonResponse<List<ProductModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['products'] != null) {
          return (json['products'] as List)
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> addCart({required AddCartData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.addCartURl,
        data: data.toMap(),
      );
      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
