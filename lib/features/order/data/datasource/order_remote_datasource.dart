import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exception.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';
import 'package:yuri_sale/features/order/domain/entities/search_order_data.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> fetchOrders({required SearchOrderData data});

  Future<Uint8List> fetchQuotationPdf({required String pdfUrl});

  Future<void> shareQuotationPdf({
    required Uint8List pdfBytes,
    required String orderNumber,
  });
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSourceImpl(this.dio);

  @override
  Future<List<OrderModel>> fetchOrders({required SearchOrderData data}) async {
    try {
      final res = await dio.get(
        AppStringsConstants.ordersURl,
        queryParameters: data.toMap(),
      );

      return CommonResponse<List<OrderModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['sale_orders'] != null) {
          return (json['sale_orders'] as List)
              .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<Uint8List> fetchQuotationPdf({required String pdfUrl}) async {
    try {
      if (pdfUrl.trim().isEmpty) {
        throw ServerException(AppStringsConstants.quotationPdfEmpty);
      }

      final response = await dio.get<List<int>>(
        pdfUrl,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          validateStatus: (status) {
            return status != null && status >= 200 && status < 400;
          },
          headers: {'Accept': 'application/pdf'},
        ),
      );

      final bytes = response.data;

      if (bytes == null || bytes.isEmpty) {
        throw ServerException(AppStringsConstants.quotationPdfResponseEmpty);
      }

      final pdfBytes = Uint8List.fromList(bytes);

      final header = String.fromCharCodes(pdfBytes.take(4).toList());

      if (!header.startsWith('%PDF')) {
        final responseText = String.fromCharCodes(pdfBytes.take(100).toList());

        throw ServerException(
          'Server did not return a valid PDF. '
          'Response: $responseText',
        );
      }

      return pdfBytes;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<void> shareQuotationPdf({
    required Uint8List pdfBytes,
    required String orderNumber,
  }) async {
    try {
      final directory = await getTemporaryDirectory();

      final fileName =
          '${orderNumber.replaceAll('/', '_')}_quotation.pdf';

      final file = File(
        '${directory.path}/$fileName',
      );

      await file.writeAsBytes(
        pdfBytes,
        flush: true,
      );

      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile(
              file.path,
              mimeType: 'application/pdf',
            ),
          ],
          subject: 'Quotation - $orderNumber',
          text: 'Quotation $orderNumber',
        ),
      );
    } catch (e) {
      throw ServerException(
        'Unable to share quotation PDF: $e',
      );
    }
  }
}
