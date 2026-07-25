import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/customer/data/model/payment_terms.dart';
import 'package:yuri_sale/features/customer/data/repository/customer_repository.dart';

class PaymentTermsUseCase {
  final CustomerRepository repository;

  PaymentTermsUseCase(this.repository);

  Future<Either<Failure, List<PaymentTermsModel>>> call() {
    return repository.fetchPaymentTerms();
  }
}
