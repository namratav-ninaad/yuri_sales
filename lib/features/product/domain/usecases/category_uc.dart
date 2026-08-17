import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/product/data/model/category.dart';
import 'package:yuri_sale/features/product/data/repository/product_repository.dart';

class CategoryUseCase {
  final ProductRepository repository;

  CategoryUseCase(this.repository);

  Future<Either<Failure, List<CategoryModel>>> call() {
    return repository.fetchCategories();
  }
}