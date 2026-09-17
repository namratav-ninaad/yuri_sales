import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/cart/data/model/cart.dart';
import 'package:yuri_sale/features/product/data/datasource/product_remote_data_source.dart';
import 'package:yuri_sale/features/product/data/model/category.dart';
import 'package:yuri_sale/features/product/data/model/product.dart' show ProductModel;
import 'package:yuri_sale/features/product/domain/entities/add_cart_data.dart';
import 'package:yuri_sale/features/product/domain/entities/product_filter_data.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> fetchProducts({
    required ProductFilterData data,
  });

  Future<Either<Failure, List<CategoryModel>>> fetchCategories();

  Future<Either<Failure, CartModel>> addCart({required AddCartData data});
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProducts({
    required ProductFilterData data,
  }) async {
    try {
      final model = await remoteDataSource.fetchProducts(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategories() async {
    try {
      final model = await remoteDataSource.fetchCategories();
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CartModel>> addCart({required AddCartData data}) async {
    try {
      final model = await remoteDataSource.addCart(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
