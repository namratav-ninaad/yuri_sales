import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/customer/data/model/contact_tag.dart';
import 'package:yuri_sale/features/customer/data/repository/customer_repository.dart';

class ContactTagUseCase {
  final CustomerRepository repository;

  ContactTagUseCase(this.repository);

  Future<Either<Failure, List<ContactTagModel>>> call() {
    return repository.fetchContactTags();
  }
}
