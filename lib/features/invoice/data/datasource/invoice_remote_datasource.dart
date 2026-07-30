import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exeptions.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/invoice/data/model/invoice.dart';
import 'package:yuri_sale/features/invoice/domain/entities/search_invoice_data.dart';

abstract class InvoiceRemoteDataSource {
  Future<List<InvoiceModel>> fetchInvoices({required SearchInvoiceData data});
}

class InvoiceRemoteDataSourceImpl implements InvoiceRemoteDataSource {
  final Dio dio;

  InvoiceRemoteDataSourceImpl(this.dio);

  @override
  Future<List<InvoiceModel>> fetchInvoices({
    required SearchInvoiceData data,
  }) async {
    try {
      final res = await dio.get(
        AppStringsConstants.invoicesURl,
        queryParameters: data.toMap(),
      );

      return CommonResponse<List<InvoiceModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['invoices'] != null) {
          return (json['invoices'] as List)
              .map((e) => InvoiceModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
