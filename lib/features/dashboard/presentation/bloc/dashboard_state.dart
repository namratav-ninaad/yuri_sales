import 'package:equatable/equatable.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/features/dashboard/data/model/dashboard.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final DashboardModel? dashboardData;
  final String period;
  final int chartType;
  final DateTime? startDate;
  final DateTime? endDate;

  const DashboardState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.dashboardData,
    this.period = AppStringsConstants.thisYearKeys,
    this.chartType = 0,
    this.startDate,
    this.endDate,
  });

  DashboardState copyWith({
    int? selectedIndex,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    DashboardModel? dashboardData,
    String? period,
    int? chartType,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      period: period ?? this.period,
      chartType: chartType ?? this.chartType,
      errorMessage: errorMessage,
      dashboardData: dashboardData ?? this.dashboardData,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    errorMessage,
    dashboardData,
    period,
    chartType,
    startDate,
    endDate,
  ];
}
