import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/quote/data/datasource/quote_remote_data_source.dart';
import 'package:yuri_sale/features/quote/domain/entity/submit_rfq_data.dart';

abstract class QuoteRepository {
  Future<Either<Failure, String>> submitRfq({required SubmitRfqData data});
}

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;

  QuoteRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> submitRfq({
    required SubmitRfqData data,
  }) async {
    try {
      final message = await remoteDataSource.submitRfq(data: data);

      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
