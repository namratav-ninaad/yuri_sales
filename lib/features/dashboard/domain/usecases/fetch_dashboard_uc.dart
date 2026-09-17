import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/dashboard/data/model/dashboard.dart';
import 'package:yuri_sale/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:yuri_sale/features/dashboard/domain/entities/dashboard_data.dart';

class FetchDashboardUseCase {
  final DashboardRepository repository;

  FetchDashboardUseCase(this.repository);

  Future<Either<Failure, DashboardModel>> call({required DashboardData data}) {
    return repository.fetchDashboard(data: data);
  }
}
