import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/delivery/data/model/delivery.dart';
import 'package:yuri_sale/features/delivery/data/repository/delivery_repository.dart';
import 'package:yuri_sale/features/delivery/domain/entities/search_delivery_data.dart';

class FetchDeliveriesUseCase {
  final DeliveryRepository repository;

  FetchDeliveriesUseCase(this.repository);

  Future<Either<Failure, List<DeliveryModel>>> call({
    required SearchDeliveryData data,
  }) {
    return repository.fetchDeliveries(data: data);
  }
}
