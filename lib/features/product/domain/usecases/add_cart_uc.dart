import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/cart/data/model/cart.dart';
import 'package:yuri_sale/features/product/data/repository/product_repository.dart';
import 'package:yuri_sale/features/product/domain/entities/add_cart_data.dart';

class AddCartUseCase {
  final ProductRepository repository;

  AddCartUseCase(this.repository);

  Future<Either<Failure, CartModel>> call({required AddCartData data}) {
    return repository.addCart(data: data);
  }
}
