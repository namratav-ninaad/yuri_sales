import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';
import 'package:yuri_sale/features/order/data/repository/order_repository.dart';

class FetchOrdersUseCase {
  final OrderRepository repository;

  FetchOrdersUseCase(this.repository);

  Future<Either<Failure, List<OrderModel>>> call({required String status}) {
    return repository.fetchOrders(status:status);
  }
}
