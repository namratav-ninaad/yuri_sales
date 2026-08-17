// ignore: depend_on_referenced_packages
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/core/share_preference/share_pref_helper.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/features/activity/data/model/user.dart';
import 'package:yuri_sale/features/activity/domain/usecases/activities_uc.dart';
import 'package:yuri_sale/features/auth/data/model/login_response_model.dart';
import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final FetchActivitiesUseCase activityUseCase;
  final CreateActivityUseCase createActivityUseCase;
  final UpdateActivityUseCase updateActivityUseCase;
  final DeleteActivityUseCase deleteActivityUseCase;
  final MarkDoneActivityUseCase markDoneActivityUseCase;
  final FetchUsersUseCase fetchUsersUseCase;

  ActivityBloc({
    required this.activityUseCase,
    required this.createActivityUseCase,
    required this.updateActivityUseCase,
    required this.deleteActivityUseCase,
    required this.markDoneActivityUseCase,
    required this.fetchUsersUseCase,
  }) : super(ActivityState()) {
    on<ResetActivityEvent>(_onResetActivity);
    on<FetchActivitiesEvent>(_onFetchActivities);
    on<FetchUsersEvent>(_onFetchUsers);
    on<MarkDoneActivityEvent>(_onMarkDoneActivity);
    on<CreateActivityEvent>(_onCreateActivity);
    on<UpdateActivityEvent>(_onUpdateActivity);
    on<DeleteActivityEvent>(_onDeleteActivity);
    on<ActivityTypeChanged>(_onActivityTypeChanged);
    on<AssignedUserChanged>(_onAssignedUserChanged);
    on<DueDateChanged>(_onDueDateChanged);
    on<InitializeActivityEvent>((event, emit) {
      emit(
        state.copyWith(
          activityType: ActivityType.values.firstWhere(
            (e) => e.apiValue == event.activity?.activityType,
            orElse: () => ActivityType.todo,
          ),
          dueDate: DateTime.parse(
            event.activity?.deadline ?? DateTime.now().toIso8601String(),
          ),
        ),
      );
    });
  }

  Future<void> _onResetActivity(
    ResetActivityEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityState());
  }

  Future<void> _onActivityTypeChanged(
    ActivityTypeChanged event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(activityType: event.activityType));
  }

  Future<void> _onAssignedUserChanged(
    AssignedUserChanged event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(assignedUser: event.assignedUser));
  }

  Future<void> _onDueDateChanged(
    DueDateChanged event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(dueDate: event.dueDate));
  }

  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await fetchUsersUseCase.call();

    await result.fold(
      (failure) async {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (users) async {
        final loginResponse = await SharedPrefHelper.getString(
          AppStringsConstants.loginResponse,
        );

        int userId = 0;
        if (loginResponse != null) {
          final loginData = LoginModel.fromJson(jsonDecode(loginResponse));
          userId = loginData.userId;
        }

        final assignedUser = users.cast<UserModel?>().firstWhere(
          (user) => user?.id == userId,
          orElse: () => null,
        );

        // Optional safety check (recommended)
        if (emit.isDone) return;

        emit(
          state.copyWith(
            isLoading: false,
            users: users,
            assignedUser: assignedUser,
          ),
        );
      },
    );
  }

  Future<void> _onFetchActivities(
    FetchActivitiesEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await activityUseCase.call(partnerId: event.partnerId);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (activity) => emit(
        state.copyWith(
          isLoading: false,
          activities: activity.activities,
          activity: activity,
        ),
      ),
    );
  }

  Future<void> _onMarkDoneActivity(
    MarkDoneActivityEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await markDoneActivityUseCase.call(data: event.data);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (activity) {
        ToastHelper.success(AppStringsConstants.activityMarkedDoneMsg);
        add(FetchActivitiesEvent(event.partnerId));
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }

  Future<void> _onCreateActivity(
    CreateActivityEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await createActivityUseCase.call(data: event.data);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (activity) {
        ToastHelper.success(AppStringsConstants.activityCreatedMsg);
        add(FetchActivitiesEvent(event.data.partnerId));
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            activityId: activity.activityId,
          ),
        );
      },
    );
  }

  Future<void> _onUpdateActivity(
    UpdateActivityEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await updateActivityUseCase.call(data: event.data);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (activity) {
        ToastHelper.success(AppStringsConstants.activityUpdatedMsg);
        add(FetchActivitiesEvent(event.data.partnerId));
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }

  Future<void> _onDeleteActivity(
    DeleteActivityEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(isLoading: false, errorMessage: null));

    final result = await deleteActivityUseCase.call(
      activityId: event.activityId,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (activity) {
        ToastHelper.success(AppStringsConstants.activityDeletedMsg);
        add(FetchActivitiesEvent(event.partnerId));
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }
}
