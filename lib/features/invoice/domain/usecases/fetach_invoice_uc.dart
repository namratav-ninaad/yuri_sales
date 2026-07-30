import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/invoice/data/model/invoice.dart';
import 'package:yuri_sale/features/invoice/data/repository/invoice_repository.dart';
import 'package:yuri_sale/features/invoice/domain/entities/search_invoice_data.dart';


class FetchInvoicesUseCase {
  final InvoiceRepository repository;

  FetchInvoicesUseCase(this.repository);

  Future<Either<Failure, List<InvoiceModel>>> call({required SearchInvoiceData data}) {
    return repository.fetchInvoices(data:data);
  }
}
