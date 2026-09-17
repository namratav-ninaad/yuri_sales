import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/dashboard/data/datasource/dashboard_remote_data_source.dart';
import 'package:yuri_sale/features/dashboard/data/model/dashboard.dart';
import 'package:yuri_sale/features/dashboard/domain/entities/dashboard_data.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardModel>> fetchDashboard({
    required DashboardData data,
  });
}

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, DashboardModel>> fetchDashboard({
    required DashboardData data,
  }) async {
    try {
      final model = await remoteDataSource.fetchDashboard(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
