import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/activity/data/model/activity.dart';
import 'package:yuri_sale/features/activity/data/model/user.dart';
import 'package:yuri_sale/features/activity/data/repository/activity_repository.dart';
import 'package:yuri_sale/features/activity/domain/entities/mark_done_data.dart';
import 'package:yuri_sale/features/activity/domain/entities/schedule_activity_data.dart';

class FetchActivitiesUseCase {
  final ActivityRepository repository;

  FetchActivitiesUseCase(this.repository);

  Future<Either<Failure, ActivityModel>> call({required int partnerId}) {
    return repository.fetchActivity(partnerId: partnerId);
  }
}

class FetchUsersUseCase {
  final ActivityRepository repository;

  FetchUsersUseCase(this.repository);

  Future<Either<Failure, List<UserModel>>> call() {
    return repository.fetchUsers();
  }
}

class CreateActivityUseCase {
  final ActivityRepository repository;

  CreateActivityUseCase(this.repository);

  Future<Either<Failure, ActivityItemModel>> call({required ScheduleActivityData data}) {
    return repository.createActivity(data: data);
  }
}

class UpdateActivityUseCase {
  final ActivityRepository repository;

  UpdateActivityUseCase(this.repository);

  Future<Either<Failure, String>> call({required ScheduleActivityData data}) {
    return repository.updateActivity(data: data);
  }
}

class MarkDoneActivityUseCase {
  final ActivityRepository repository;

  MarkDoneActivityUseCase(this.repository);

  Future<Either<Failure, String>> call({required MarkDoneData data}) {
    return repository.markDoneActivity(data: data);
  }
}

class DeleteActivityUseCase {
  final ActivityRepository repository;

  DeleteActivityUseCase(this.repository);

  Future<Either<Failure, String>> call({required int activityId}) {
    return repository.deleteActivity(activityId: activityId);
  }
}
