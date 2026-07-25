import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/cart/data/repository/cart_repository.dart';

class RemoveCartUseCase {
  final CartRepository repository;

  RemoveCartUseCase(this.repository);

  Future<Either<Failure, String>> call({required int lineId}) {
    return repository.removeCart(lineId: lineId);
  }
}
