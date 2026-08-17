import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/activity/data/datasource/activity_remote_datasource.dart';
import 'package:yuri_sale/features/activity/data/model/activity.dart';
import 'package:yuri_sale/features/activity/data/model/user.dart';
import 'package:yuri_sale/features/activity/domain/entities/mark_done_data.dart';
import 'package:yuri_sale/features/activity/domain/entities/schedule_activity_data.dart';

abstract class ActivityRepository {
  Future<Either<Failure, ActivityModel>> fetchActivity({
    required int partnerId,
  });


  Future<Either<Failure,List<UserModel>>> fetchUsers();

  Future<Either<Failure, ActivityItemModel>> createActivity({
    required ScheduleActivityData data,
  });

  Future<Either<Failure, String>> updateActivity({
    required ScheduleActivityData data,
  });

  Future<Either<Failure, String>> deleteActivity({required int activityId});

  Future<Either<Failure, String>> markDoneActivity({
    required MarkDoneData data,
  });
}

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource remoteDataSource;

  ActivityRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ActivityModel>> fetchActivity({
    required int partnerId,
  }) async {
    try {
      final model = await remoteDataSource.fetchActivity(partnerId: partnerId);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> fetchUsers() async {
    try {
      final model = await remoteDataSource.fetchUsers();
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }


  @override
  Future<Either<Failure, ActivityItemModel>> createActivity({
    required ScheduleActivityData data,
  }) async {
    try {
      final model = await remoteDataSource.createActivity(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateActivity({
    required ScheduleActivityData data,
  }) async {
    try {
      final model = await remoteDataSource.updateActivity(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> markDoneActivity({
    required MarkDoneData data,
  }) async {
    try {
      final model = await remoteDataSource.markDoneActivity(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteActivity({
    required int activityId,
  }) async {
    try {
      final model = await remoteDataSource.deleteActivity(
        activityId: activityId,
      );
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
