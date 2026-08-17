import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/customer/data/model/company.dart';
import 'package:yuri_sale/features/customer/data/repository/customer_repository.dart';

class CompanyUseCase {
  final CustomerRepository repository;

  CompanyUseCase(this.repository);

  Future<Either<Failure, List<CompanyModel>>> call() {
    return repository.fetchCompanies();
  }
}
