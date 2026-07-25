import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/customer/data/model/state.dart';
import 'package:yuri_sale/features/customer/data/repository/customer_repository.dart';

class StateUseCase {
  final CustomerRepository repository;

  StateUseCase(this.repository);

  Future<Either<Failure, List<StateModel>>> call({required int countryId}) {
    return repository.fetchStates(countryId: countryId);
  }
}
