import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Fetch Dashboard Event
class FetchDashboardEvent extends DashboardEvent {
  final String period;

  FetchDashboardEvent(this.period);

  @override
  List<Object?> get props => [period];
}

/// Change selected period
class ChangeDashboardPeriodEvent extends DashboardEvent {
  final String period;

  ChangeDashboardPeriodEvent(this.period);

  @override
  List<Object?> get props => [period];
}

/// Change selected chart
class ChangeDashboardChartEvent extends DashboardEvent {
  final int chartType;

  ChangeDashboardChartEvent(this.chartType);

  @override
  List<Object?> get props => [chartType];
}

/// Change Dashboard StartDate Event
class ChangeDashboardStartDateEvent extends DashboardEvent {
  final DateTime date;

  ChangeDashboardStartDateEvent(this.date);
}

/// Change Dashboard EndDate Event
class ChangeDashboardEndDateEvent extends DashboardEvent {
  final DateTime date;

  ChangeDashboardEndDateEvent(this.date);
}
