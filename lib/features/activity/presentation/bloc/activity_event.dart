import 'package:equatable/equatable.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/features/activity/data/model/activity.dart';
import 'package:yuri_sale/features/activity/data/model/user.dart';
import 'package:yuri_sale/features/activity/domain/entities/mark_done_data.dart';
import 'package:yuri_sale/features/activity/domain/entities/schedule_activity_data.dart';

abstract class ActivityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetActivityEvent extends ActivityEvent {}


class FetchUsersEvent extends ActivityEvent {}

class FetchActivitiesEvent extends ActivityEvent {
  final int partnerId;

  FetchActivitiesEvent(this.partnerId);

  @override
  List<Object?> get props => [partnerId];
}

class MarkDoneActivityEvent extends ActivityEvent {
  final MarkDoneData data;
  final int partnerId;

  MarkDoneActivityEvent({required this.data, required this.partnerId});

  @override
  List<Object?> get props => [data, partnerId];
}

class CreateActivityEvent extends ActivityEvent {
  final ScheduleActivityData data;

  CreateActivityEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class UpdateActivityEvent extends ActivityEvent {
  final ScheduleActivityData data;

  UpdateActivityEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class DeleteActivityEvent extends ActivityEvent {
  final int activityId;
  final int partnerId;

  DeleteActivityEvent({required this.activityId, required this.partnerId});

  @override
  List<Object?> get props => [activityId, partnerId];
}

class ActivityTypeChanged extends ActivityEvent {
  final ActivityType activityType;

  ActivityTypeChanged(this.activityType);
}

class AssignedUserChanged extends ActivityEvent {
  final UserModel assignedUser;

  AssignedUserChanged({required this.assignedUser});
}

class DueDateChanged extends ActivityEvent {
  final DateTime dueDate;

  DueDateChanged(this.dueDate);
}

class InitializeActivityEvent extends ActivityEvent {
  final ActivityItemModel? activity;

  InitializeActivityEvent(this.activity);
}
