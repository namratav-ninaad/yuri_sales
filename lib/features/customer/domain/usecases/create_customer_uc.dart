import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/customer/data/repository/customer_repository.dart';
import 'package:yuri_sale/features/customer/domain/entities/create_customer_data.dart';

class CreateCustomerUseCase {
  final CustomerRepository repository;

  CreateCustomerUseCase(this.repository);

  Future<Either<Failure, String>> call({required CreateCustomerData data}) {
    return repository.createCustomers(data: data);
  }
}
