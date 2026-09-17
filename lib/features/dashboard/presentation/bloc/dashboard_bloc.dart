import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/widgets/date_helper.dart';
import 'package:yuri_sale/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:yuri_sale/features/dashboard/domain/usecases/fetch_dashboard_uc.dart';
import 'package:yuri_sale/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:yuri_sale/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FetchDashboardUseCase dashboardUseCase;

  DashboardBloc({required this.dashboardUseCase})
    : super(const DashboardState()) {
    on<FetchDashboardEvent>(_onFetchDashboard);
    on<ChangeDashboardPeriodEvent>(_onChangePeriod);
    on<ChangeDashboardChartEvent>(_onChangeChart);
    on<ChangeDashboardStartDateEvent>(_onChangeStartDate);
    on<ChangeDashboardEndDateEvent>(_onChangeEndDate);
  }

  // FETCH DASHBOARD

  Future<void> _onFetchDashboard(
    FetchDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    final isCustom = event.period == AppStringsConstants.customKeys;

    // Custom period requires both dates
    if (isCustom && (state.startDate == null || state.endDate == null)) {
      debugPrint('Custom period selected but start/end date is missing');
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final dashboardData = DashboardData(
      period: event.period,
      startDate: isCustom
          ? DateHelper.yMd(state.startDate!.toIso8601String())
          : null,
      endDate: isCustom
          ? DateHelper.yMd(state.endDate!.toIso8601String())
          : null,
    );

    debugPrint(
      'Dashboard Request => '
      'period: ${dashboardData.period}, '
      'startDate: ${dashboardData.startDate}, '
      'endDate: ${dashboardData.endDate}',
    );

    final result = await dashboardUseCase.call(data: dashboardData);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (data) {
        emit(
          state.copyWith(
            isLoading: false,
            dashboardData: data,
            errorMessage: null,
          ),
        );
      },
    );
  }

  // CHANGE PERIOD

  void _onChangePeriod(
    ChangeDashboardPeriodEvent event,
    Emitter<DashboardState> emit,
  ) {
    final isCustom = event.period == AppStringsConstants.customKeys;

    if (isCustom) {
      // Clear previous dates when switching to Custom
      emit(
        state.copyWith(
          period: event.period,
          startDate: null,
          endDate: null,
          errorMessage: null,
        ),
      );

      debugPrint('Custom selected');
      debugPrint('Start Date cleared');
      debugPrint('End Date cleared');

      return;
    }

    // For other periods clear custom dates
    emit(
      state.copyWith(
        period: event.period,
        startDate: null,
        endDate: null,
        errorMessage: null,
      ),
    );

    debugPrint('Period changed: ${event.period}');

    // Other periods call API immediately
    add(FetchDashboardEvent(event.period));
  }

  // CHANGE CHART

  void _onChangeChart(
    ChangeDashboardChartEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(chartType: event.chartType));
  }

  // CHANGE START DATE

  void _onChangeStartDate(
    ChangeDashboardStartDateEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(startDate: event.date, errorMessage: null));

    debugPrint('Start Date selected: ${event.date}');

    // API call only when End Date already exists
    if (state.endDate != null &&
        state.period == AppStringsConstants.customKeys) {
      debugPrint('Both dates available → Fetch Custom Dashboard');

      add(FetchDashboardEvent(AppStringsConstants.customKeys));
    }
  }

  // CHANGE END DATE

  void _onChangeEndDate(
    ChangeDashboardEndDateEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(endDate: event.date, errorMessage: null));

    debugPrint('End Date selected: ${event.date}');

    // API call only when Start Date already exists
    if (state.startDate != null &&
        state.period == AppStringsConstants.customKeys) {
      debugPrint('Both dates available → Fetch Custom Dashboard');

      add(FetchDashboardEvent(AppStringsConstants.customKeys));
    }
  }
}
