import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/order/data/datasource/order_remote_datasource.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> fetchOrders({required String status});
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<OrderModel>>> fetchOrders({required String status}) async {
    try {
      final model = await remoteDataSource.fetchOrders(status:status);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
