import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/cart/data/repository/cart_repository.dart';
import 'package:yuri_sale/features/cart/domain/entities/update_cart_qty.dart';

class UpdateCartQtyUseCase {
  final CartRepository repository;

  UpdateCartQtyUseCase(this.repository);

  Future<Either<Failure, String>> call({required UpdateCartQty data}) {
    return repository.updateCartQty(data: data);
  }
}
