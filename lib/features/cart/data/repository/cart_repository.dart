import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:yuri_sale/features/cart/data/model/cart.dart';
import 'package:yuri_sale/features/cart/domain/entities/update_cart_qty.dart';

abstract class CartRepository {
  Future<Either<Failure, CartModel>> fetchCart();

  Future<Either<Failure, String>> updateCartQty({required UpdateCartQty data});

  Future<Either<Failure, String>> removeCart({required int lineId});
}

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDatasource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, CartModel>> fetchCart() async {
    try {
      final model = await remoteDataSource.fetchCart();
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateCartQty({required UpdateCartQty data}) async {
    try {
      final model = await remoteDataSource.updateCartQty(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeCart({required int lineId}) async {
    try {
      final model = await remoteDataSource.removeCart(lineId: lineId);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
