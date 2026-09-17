import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/order/data/datasource/order_remote_datasource.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';
import 'package:yuri_sale/features/order/domain/entities/search_order_data.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> fetchOrders({
    required SearchOrderData data,
  });

  Future<Either<Failure, Uint8List>> fetchQuotationPdf({
    required String pdfUrl,
  });

  Future<void> shareQuotationPdf({
    required Uint8List pdfBytes,
    required String orderNumber,
  });
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<OrderModel>>> fetchOrders({
    required SearchOrderData data,
  }) async {
    try {
      final model = await remoteDataSource.fetchOrders(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Uint8List>> fetchQuotationPdf({
    required String pdfUrl,
  }) async {
    try {
      final model = await remoteDataSource.fetchQuotationPdf(pdfUrl: pdfUrl);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> shareQuotationPdf({
    required Uint8List pdfBytes,
    required String orderNumber,
  }) async {
    try {
      final model = await remoteDataSource.shareQuotationPdf(
        orderNumber: orderNumber,
        pdfBytes: pdfBytes,
      );
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
