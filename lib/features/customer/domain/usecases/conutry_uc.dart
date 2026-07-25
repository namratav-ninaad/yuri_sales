import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/customer/data/model/country.dart';
import 'package:yuri_sale/features/customer/data/repository/customer_repository.dart';

class CountryUseCase {
  final CustomerRepository repository;

  CountryUseCase(this.repository);

  Future<Either<Failure, List<CountryModel>>> call() {
    return repository.fetchCountries();
  }
}
