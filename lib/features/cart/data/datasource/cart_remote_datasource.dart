import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exception.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/cart/data/model/cart.dart';
import 'package:yuri_sale/features/cart/domain/entities/update_cart_qty.dart';

abstract class CartRemoteDatasource {
  Future<CartModel> fetchCart();

  Future<String> updateCartQty({required UpdateCartQty data});

  Future<String> removeCart({required int lineId});
}

class CartRemoteDatasourceImpl implements CartRemoteDatasource {
  final Dio dio;

  CartRemoteDatasourceImpl(this.dio);

  @override
  Future<CartModel> fetchCart() async {
    try {
      final response = await dio.get(AppStringsConstants.cartURl);

      return CommonResponse<CartModel>.fromJson(
        response.data,
        (json) => CartModel.fromJson(json as Map<String, dynamic>),
      ).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> updateCartQty({required UpdateCartQty data}) async {
    try {
      final response = await dio.put(
        AppStringsConstants.cartUpdateURl,
        data: data.toMap(),
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> removeCart({required int lineId}) async {
    try {
      final response = await dio.delete(
        AppStringsConstants.cartRemoveURl,
        data: {'line_id': lineId},
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
