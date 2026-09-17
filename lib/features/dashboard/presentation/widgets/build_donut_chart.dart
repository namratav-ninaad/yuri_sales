import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/dashboard/data/model/dashboard.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_legend_item.dart';

class BuildDonutChart extends StatefulWidget {
  const BuildDonutChart({
    super.key,
    required this.revenueTrend,
    required this.selectedPeriod,
    required this.currencyName,
  });

  final List<RevenueTrend> revenueTrend;
  final String selectedPeriod;
  final String currencyName;

  @override
  State<BuildDonutChart> createState() => _BuildDonutChartState();
}

class _BuildDonutChartState extends State<BuildDonutChart> {
  int touchedIndex = -1;

  @override
  void didUpdateWidget(covariant BuildDonutChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedPeriod != widget.selectedPeriod ||
        oldWidget.revenueTrend != widget.revenueTrend ||
        oldWidget.currencyName != widget.currencyName) {
      touchedIndex = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chartData = _preparePieData();

    // NO DATA

    if (chartData.isEmpty) {
      return const Center(
        child: CommonEmptyText(title: AppStringsConstants.noRevenueData),
      );
    }

    // TOTAL REVENUE

    final totalRevenue = chartData.fold<double>(
      0,
      (sum, item) => sum + item.revenue,
    );

    if (totalRevenue <= 0) {
      return const Center(
        child: CommonEmptyText(title: AppStringsConstants.noRevenueData),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // DONUT CHART

        Expanded(
          child: SizedBox(
            height: 230,
            child: SfCircularChart(
              margin: EdgeInsets.zero,

              // TOOLTIP
              tooltipBehavior: TooltipBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                color: context.black,
                builder:
                    (
                      dynamic data,
                      dynamic point,
                      dynamic series,
                      int pointIndex,
                      int seriesIndex,
                    ) {
                      final item = data as _PieRevenueData;

                      return Padding(
                        padding: const EdgeInsets.all(AppSizes.p8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget(
                              title: item.title,
                              color: context.white,
                              fontSize: AppSizes.f10,
                              fontWeight: FontWeight.w600,
                            ),
                            AppSizes.h4,
                            CommonTextWidget(
                              title:
                                  '${widget.currencyName}\t${item.revenue.toStringAsFixed(2)}',
                              color: context.white,
                              fontSize: AppSizes.f10,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      );
                    },
              ),

              // DONUT SERIES
              series: <CircularSeries<_PieRevenueData, String>>[
                DoughnutSeries<_PieRevenueData, String>(
                  dataSource: chartData,

                  // X VALUE
                  xValueMapper: (_PieRevenueData item, _) {
                    return item.title;
                  },

                  // Y VALUE
                  yValueMapper: (_PieRevenueData item, _) {
                    return item.revenue;
                  },

                  // COLOR
                  pointColorMapper: (_PieRevenueData item, _) {
                    return item.color;
                  },

                  // DONUT SIZE
                  radius: '90%',
                  innerRadius: '55%',

                  // BORDER
                  strokeColor: context.white,
                  strokeWidth: 3,

                  // DATA LABEL
                  dataLabelSettings: const DataLabelSettings(isVisible: false),

                  // ANIMATION
                  animationDuration: 500,

                  // SELECTION
                  selectionBehavior: SelectionBehavior(
                    enable: true,
                    toggleSelection: false,
                  ),
                ),
              ],
            ),
          ),
        ),

        AppSizes.w16,

        // LEGEND
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: chartData.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.p12),
                child: BuildLegendItem(
                  color: item.color,
                  title:
                      '${item.title} '
                      '(${item.percentage.toStringAsFixed(1)}%)',
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // PREPARE PIE DATA

  List<_PieRevenueData> _preparePieData() {
    if (widget.revenueTrend.isEmpty) {
      return [];
    }

    final Map<String, _RevenueGroup> revenueMap = {};

    // CHECK YEAR PERIOD

    final bool isYearPeriod =
        widget.selectedPeriod == AppStringsConstants.thisYearKeys ||
        widget.selectedPeriod == AppStringsConstants.previousYearKeys;

    // GROUP DATA

    for (final item in widget.revenueTrend) {
      final date = _parseDate(item.date);

      if (date == null) {
        continue;
      }

      final revenue = _toDouble(item.revenue);

      // Ignore zero / negative revenue.
      if (revenue <= 0) {
        continue;
      }

      // YEAR PERIOD

      final String groupKey;

      if (isYearPeriod) {
        groupKey =
            '${date.year}-'
            '${date.month.toString().padLeft(2, '0')}';
      }
      // OTHER PERIOD
      else {
        groupKey =
            '${date.year}-'
            '${date.month.toString().padLeft(2, '0')}-'
            '${date.day.toString().padLeft(2, '0')}';
      }

      // ADD / UPDATE GROUP

      if (revenueMap.containsKey(groupKey)) {
        final existing = revenueMap[groupKey]!;

        revenueMap[groupKey] = _RevenueGroup(
          date: existing.date,
          revenue: existing.revenue + revenue,
        );
      } else {
        revenueMap[groupKey] = _RevenueGroup(date: date, revenue: revenue);
      }
    }

    // NO GROUPED DATA

    if (revenueMap.isEmpty) {
      return [];
    }

    // SORT HIGH → LOW

    final sortedData = revenueMap.values.toList();

    sortedData.sort((a, b) => b.revenue.compareTo(a.revenue));

    // TOP 5

    final topData = sortedData.length > 5
        ? sortedData.sublist(0, 5)
        : sortedData;

    // TOTAL OF TOP 5

    final totalRevenue = topData.fold<double>(
      0,
      (sum, item) => sum + item.revenue,
    );

    if (totalRevenue <= 0) {
      return [];
    }

    // CREATE DONUT DATA

    return List.generate(topData.length, (index) {
      final entry = topData[index];

      final percentage = (entry.revenue / totalRevenue) * 100;

      return _PieRevenueData(
        date: entry.date,
        title: _formatBottomTitle(entry.date),
        revenue: entry.revenue,
        percentage: percentage,
        color: _getColor(index),
      );
    });
  }

  // FORMAT TITLE

  String _formatBottomTitle(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    // THIS YEAR / PREVIOUS YEAR

    if (widget.selectedPeriod == AppStringsConstants.thisYearKeys ||
        widget.selectedPeriod == AppStringsConstants.previousYearKeys) {
      return '${months[date.month - 1]} ${date.year}';
    }

    // THIS QUARTER / THIS MONTH / LAST MONTH

    if (widget.selectedPeriod == AppStringsConstants.thisQuarterKeys ||
        widget.selectedPeriod == AppStringsConstants.thisMonthKeys ||
        widget.selectedPeriod == AppStringsConstants.lastMonthKeys) {
      return '${date.day} ${months[date.month - 1]}';
    }

    // THIS WEEK

    if (widget.selectedPeriod == AppStringsConstants.thisWeekKeys) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

      return days[date.weekday - 1];
    }

    // DEFAULT

    return '${date.day} ${months[date.month - 1]}';
  }

  // PARSE DATE

  DateTime? _parseDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (_) {
      return null;
    }
  }

  // CONVERT TO DOUBLE

  double _toDouble(dynamic value) {
    if (value == null) {
      return 0;
    }

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString()) ?? 0;
  }

  // COLORS

  Color _getColor(int index) {
    const colors = [
      AppColorsConstants.blue,
      AppColorsConstants.green,
      AppColorsConstants.orange,
      AppColorsConstants.purple,
      AppColorsConstants.teal,
      AppColorsConstants.amber,
      AppColorsConstants.pink,
      AppColorsConstants.indigo,
      AppColorsConstants.cyan,
      AppColorsConstants.brown,
    ];

    return colors[index % colors.length];
  }
}

// REVENUE GROUP

class _RevenueGroup {
  final DateTime date;
  final double revenue;

  const _RevenueGroup({required this.date, required this.revenue});
}

// PIE REVENUE MODEL

class _PieRevenueData {
  final DateTime date;
  final String title;
  final double revenue;
  final double percentage;
  final Color color;

  const _PieRevenueData({
    required this.date,
    required this.title,
    required this.revenue,
    required this.percentage,
    required this.color,
  });
}
