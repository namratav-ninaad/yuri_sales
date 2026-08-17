import 'package:equatable/equatable.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/features/activity/data/model/activity.dart';
import 'package:yuri_sale/features/activity/data/model/user.dart';

class ActivityState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final int? loadingProductId;
  final ActivityModel? activity;
  final List<ActivityItemModel> activities;
  final String? errorMessage;
  final String searchQuery;
  final ActivityType activityType;
  final UserModel? assignedUser;
  final DateTime dueDate;
  final List<UserModel> users;
  final int activityId;

  ActivityState({
    this.activityType = ActivityType.todo,
    this.assignedUser,
    DateTime? dueDate,
    this.isLoading = false,
    this.isSuccess = false,
    this.activities = const [],
    this.errorMessage,
    this.searchQuery = '',
    this.loadingProductId,
    this.activityId = 0,
    this.activity,
    this.users = const [],
  }) : dueDate = dueDate ?? DateTime.now();

  ActivityState copyWith({
    ActivityType? activityType,
    UserModel? assignedUser,
    DateTime? dueDate,
    bool? isLoading,
    List<ActivityItemModel>? activities,
    List<UserModel>? users,
    ActivityModel? activity,
    String? errorMessage,
    String? searchQuery,
    int? loadingProductId,
    bool? isSuccess,
    int? activityId,
  }) {
    return ActivityState(
      activityType: activityType ?? this.activityType,
      assignedUser: assignedUser ?? this.assignedUser,
      dueDate: dueDate ?? this.dueDate,
      isLoading: isLoading ?? this.isLoading,
      activity: activity ?? this.activity,
      loadingProductId: loadingProductId,
      users: users ?? this.users,
      activities: activities ?? this.activities,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      isSuccess: isSuccess ?? this.isSuccess,
      activityId: activityId ?? this.activityId,
    );
  }

  @override
  List<Object?> get props => [
    activityId,
    activityType,
    assignedUser,
    activity,
    dueDate,
    users,
    loadingProductId,
    isLoading,
    activities,
    errorMessage,
    searchQuery,
    isSuccess,
  ];
}
