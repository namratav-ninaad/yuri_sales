import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/delivery/data/datasource/delivery_remote_data_source.dart';
import 'package:yuri_sale/features/delivery/data/model/delivery.dart';
import 'package:yuri_sale/features/delivery/domain/entities/search_delivery_data.dart';


abstract class DeliveryRepository {
  Future<Either<Failure, List<DeliveryModel>>> fetchDeliveries({
    required SearchDeliveryData data
  });
}

class DeliveryRepositoryImpl implements DeliveryRepository {
  final DeliveryRemoteDataSource remoteDataSource;

  DeliveryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<DeliveryModel>>> fetchDeliveries({
    required SearchDeliveryData data
  }) async {
    try {
      final model = await remoteDataSource.fetchDeliveries(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
