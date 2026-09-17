import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/features/dashboard/data/model/dashboard.dart';

class BuildBarChart extends StatelessWidget {
  final List<RevenueTrend> revenueTrend;
  final String selectedPeriod;
  final String currencyName;

  const BuildBarChart({
    super.key,
    required this.revenueTrend,
    required this.selectedPeriod, required this.currencyName,
  });

  @override
  Widget build(BuildContext context) {
    if (revenueTrend.isEmpty) {
      return const SizedBox(
        height: 240,
        child: Center(
          child: CommonEmptyText(title: AppStringsConstants.noRevenueData),
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: SfCartesianChart(
        // ========== ZOOM & PAN ==========
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
          enableDoubleTapZooming: true,
          enableMouseWheelZooming: true,
          zoomMode: ZoomMode.x,
        ),

        // ========== TOOLTIP ==========
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: '',
          canShowMarker: true,
          format: 'point.x : \$point.y',
        ),

        // ========== GRID & AXIS ==========
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelRotation: -45,
          labelStyle: TextStyle(fontSize: AppSizes.f8, color: context.grey89),
          // Show fewer labels when many points
          interval: _getLabelInterval().toDouble(),
          maximumLabels: 10,
        ),

        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 1, color: context.greyF2),
          axisLine: const AxisLine(width: 0),
          labelStyle: TextStyle(fontSize: AppSizes.f8, color: context.grey89),
          numberFormat: null,
          // we format manually below
          axisLabelFormatter: (AxisLabelRenderDetails details) {
            return ChartAxisLabel(
              _formatAmount(details.value.toDouble()),
              TextStyle(fontSize: AppSizes.f8, color: context.grey89),
            );
          },
        ),

        // ========== SERIES (BARS) ==========
        series: <CartesianSeries<RevenueTrend, String>>[
          ColumnSeries<RevenueTrend, String>(
            dataSource: revenueTrend,
            xValueMapper: (RevenueTrend data, _) =>
                _formatBottomTitle(data.date),
            yValueMapper: (RevenueTrend data, _) => data.revenue,
            name: AppStringsConstants.revenue,
            color: context.primaryRedColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSizes.r4),
              topRight: Radius.circular(AppSizes.r4),
            ),
            width: 1,
            // bar thickness
            spacing: 0.2,
          ),
        ],
      ),
    );
  }

  // ===================== HELPERS =====================

  String _formatBottomTitle(String date) {
    try {
      final parsed = DateTime.parse(date);

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

      if (selectedPeriod == AppStringsConstants.thisYearKeys ||
          selectedPeriod == AppStringsConstants.previousYearKeys) {
        return '${months[parsed.month - 1]} ${parsed.year}';
      }

      if (selectedPeriod == AppStringsConstants.thisQuarterKeys ||
          selectedPeriod == AppStringsConstants.thisMonthKeys ||
          selectedPeriod == AppStringsConstants.lastMonthKeys) {
        return '${parsed.day} ${months[parsed.month - 1]}';
      }

      if (selectedPeriod == AppStringsConstants.thisWeekKeys) {
        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return days[parsed.weekday - 1];
      }

      // Default
      return '${parsed.day} ${months[parsed.month - 1]}';
    } catch (_) {
      return date;
    }
  }

  int _getLabelInterval() {
    if (selectedPeriod == AppStringsConstants.thisMonthKeys ||
        selectedPeriod == AppStringsConstants.lastMonthKeys) {
      return 3;
    }
    if (selectedPeriod == AppStringsConstants.thisQuarterKeys) {
      return 15;
    }
    if (selectedPeriod == AppStringsConstants.thisYearKeys ||
        selectedPeriod == AppStringsConstants.previousYearKeys) {
      return 2;
    }
    return 1;
  }

  String _formatAmount(double value) {
    if (value == 0) return '${currencyName}0';
    if (value >= 1000000) return '$currencyName${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '$currencyName${(value / 1000).toStringAsFixed(1)}K';
    return '$currencyName${value.toStringAsFixed(0)}';
  }
}
