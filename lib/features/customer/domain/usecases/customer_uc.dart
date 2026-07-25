import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart';
import 'package:yuri_sale/features/customer/data/repository/customer_repository.dart';
import 'package:yuri_sale/features/customer/domain/entities/customer_filter_data.dart';

class CustomerUseCase {
  final CustomerRepository repository;

  CustomerUseCase(this.repository);

  Future<Either<Failure, List<CustomerModel>>> call({required CustomerFilterData data}) {
    return repository.fetchCustomers(data: data);
  }
}
