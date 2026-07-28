import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/quote/data/repository/quote_repository.dart';
import 'package:yuri_sale/features/quote/domain/entity/submit_rfq_data.dart';

class SubmitRfqUseCase {
  final QuoteRepository repository;

  SubmitRfqUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required SubmitRfqData data,
  }) {
    return repository.submitRfq(data: data);
  }
}