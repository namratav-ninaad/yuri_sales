import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/cart/data/model/cart.dart';
import 'package:yuri_sale/features/cart/data/repository/cart_repository.dart';

class CartUseCase {
  final CartRepository repository;

  CartUseCase(this.repository);

  Future<Either<Failure, CartModel>> call() {
    return repository.fetchCart();
  }
}
