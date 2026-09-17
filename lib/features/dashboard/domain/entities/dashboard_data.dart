class DashboardData {
  final String period;
  final String? startDate;
  final String? endDate;

  const DashboardData({required this.period, this.startDate, this.endDate});

  Map<String, dynamic> toQuery() {
    return {
      "period": period,
      if (startDate != null) "start_date": startDate,
      if (endDate != null) "end_date": endDate,
    };
  }
}
