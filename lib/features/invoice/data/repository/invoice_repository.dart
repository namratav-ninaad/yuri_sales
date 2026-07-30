import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/invoice/data/datasource/invoice_remote_datasource.dart';
import 'package:yuri_sale/features/invoice/data/model/invoice.dart';
import 'package:yuri_sale/features/invoice/domain/entities/search_invoice_data.dart';

abstract class InvoiceRepository {
  Future<Either<Failure, List<InvoiceModel>>> fetchInvoices({
    required SearchInvoiceData data
  });
}

class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceRemoteDataSource remoteDataSource;

  InvoiceRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<InvoiceModel>>> fetchInvoices({
    required SearchInvoiceData data
  }) async {
    try {
      final model = await remoteDataSource.fetchInvoices(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
