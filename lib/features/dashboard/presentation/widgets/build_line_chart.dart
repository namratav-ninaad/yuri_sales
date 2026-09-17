import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/core/widgets/date_helper.dart';

class BuildLineChart extends StatelessWidget {
  final List revenueTrend;
  final String currencyName;
  final String selectedPeriod;

  const BuildLineChart({
    super.key,
    required this.revenueTrend,
    required this.currencyName,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    if (revenueTrend.isEmpty) {
      return const Center(
        child: CommonEmptyText(title: AppStringsConstants.noRevenueData),
      );
    }

    final chartData = revenueTrend
        .map(
          (item) => RevenueChartData(
            date: _parseDate(item.date),
            revenue: _toDouble(item.revenue),
          ),
        )
        .where((item) => item.date != null)
        .toList();

    if (chartData.isEmpty) {
      return const Center(
        child: CommonEmptyText(title: AppStringsConstants.noRevenueData),
      );
    }

    final maxRevenue = chartData.fold<double>(
      0,
      (previous, item) => math.max(previous, item.revenue),
    );

    final chartMaxY = _calculateMaxY(maxRevenue);
    final interval = _getInterval(chartMaxY);

    return SfCartesianChart(
      plotAreaBorderWidth: 0,

      // ZOOM / PAN
      zoomPanBehavior: ZoomPanBehavior(
        enablePinching: true,
        enablePanning: true,
        enableMouseWheelZooming: true,
        enableSelectionZooming: true,

        // Only X-axis zoom
        zoomMode: ZoomMode.x,
      ),

      // X AXIS
      primaryXAxis: DateTimeAxis(
        intervalType: _getIntervalType(),

        // Important:
        // Use smaller interval so titles remain available
        // after zoom in / zoom out.
        interval: _getXAxisInterval(),

        // Keep labels visible instead of hiding them
        labelIntersectAction: AxisLabelIntersectAction.rotate45,

        labelRotation: -45,

        // Do not hide edge labels
        edgeLabelPlacement: EdgeLabelPlacement.shift,

        majorGridLines: const MajorGridLines(width: 0),

        minorGridLines: const MinorGridLines(width: 0),

        axisLine: const AxisLine(width: 0),

        majorTickLines: const MajorTickLines(width: 0),

        labelStyle: TextStyle(
          fontSize: AppSizes.f8,
          color: context.grey89,
          fontWeight: FontWeight.w400,
        ),

        // DATE LABEL FORMAT
        axisLabelFormatter: (AxisLabelRenderDetails details) {
          final date = DateTime.fromMillisecondsSinceEpoch(
            details.value.toInt(),
          );

          return ChartAxisLabel(
            _formatBottomTitleFromDate(date),
            TextStyle(
              fontSize: AppSizes.f8,
              color: context.grey89,
              fontWeight: FontWeight.w400,
            ),
          );
        },
      ),

      // Y AXIS
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: chartMaxY,
        interval: interval,

        majorGridLines: MajorGridLines(width: 1, color: context.greyF2),

        minorGridLines: const MinorGridLines(width: 0),

        axisLine: const AxisLine(width: 0),

        majorTickLines: const MajorTickLines(width: 0),

        labelStyle: TextStyle(
          fontSize: AppSizes.f10,
          color: context.grey89,
          fontWeight: FontWeight.w400,
        ),

        axisLabelFormatter: (AxisLabelRenderDetails details) {
          return ChartAxisLabel(
            _formatAxisValue(details.value.toDouble()),
            TextStyle(
              fontSize: AppSizes.f10,
              color: context.grey89,
              fontWeight: FontWeight.w400,
            ),
          );
        },
      ),

      // TOOLTIP
      tooltipBehavior: TooltipBehavior(
        enable: true,

        activationMode: ActivationMode.singleTap,

        canShowMarker: true,

        header: '',

        color: context.primaryRedColor,

        duration: 3000,

        textStyle: TextStyle(
          color: context.white,
          fontSize: AppSizes.f10,
          fontWeight: FontWeight.w700,
        ),

        builder:
            (
              dynamic data,
              dynamic point,
              dynamic series,
              int pointIndex,
              int seriesIndex,
            ) {
              final item = chartData[pointIndex];

              final date = item.date!;

              return Container(
                constraints: const BoxConstraints(minWidth: 130),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.p12,
                  vertical: AppSizes.p8,
                ),
                decoration: BoxDecoration(
                  color: context.primaryRedColor,
                  borderRadius: BorderRadius.circular(AppSizes.r8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE / DATE

                    CommonTextWidget(
                      title: _formatTooltipDate(date),
                      color: context.white,
                      fontSize: AppSizes.f10,
                      fontWeight: FontWeight.w500,
                    ),
                    AppSizes.h4,

                    // REVENUE
                    CommonTextWidget(
                      title:
                          '${AppStringsConstants.revenue}: '
                          '$currencyName '
                          '${_formatAmount(item.revenue)}',
                      color: context.white,
                      fontSize: AppSizes.f10,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              );
            },
      ),

      // TRACKBALL
      trackballBehavior: TrackballBehavior(
        enable: true,

        activationMode: ActivationMode.singleTap,

        lineType: TrackballLineType.vertical,

        lineColor: context.primaryRedColor,

        lineWidth: 1,

        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,

        tooltipSettings: InteractiveTooltip(
          color: context.primaryRedColor,
          textStyle: TextStyle(
            color: context.white,
            fontSize: AppSizes.f10,
            fontWeight: FontWeight.w700,
          ),
        ),

        markerSettings: TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible,
          height: 7,
          width: 7,
          borderWidth: 2,
          borderColor: context.primaryRedColor,
          color: context.white,
        ),
      ),

      // SERIES
      series: <CartesianSeries<RevenueChartData, DateTime>>[
        SplineAreaSeries<RevenueChartData, DateTime>(
          dataSource: chartData,

          xValueMapper: (RevenueChartData data, _) {
            return data.date!;
          },

          yValueMapper: (RevenueChartData data, _) {
            return data.revenue;
          },

          name: AppStringsConstants.revenue,

          color: context.primaryRedColor.withValues(alpha: 0.12),

          borderColor: context.primaryRedColor,

          borderWidth: 2,

          splineType: SplineType.natural,

          markerSettings: MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
            color: context.white,
            borderColor: context.primaryRedColor,
            borderWidth: 2,
          ),

          emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.gap),

          animationDuration: 500,

          enableTooltip: true,
        ),
      ],
    );
  }

  // DATE PARSER

  DateTime? _parseDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (_) {
      return null;
    }
  }

  // REVENUE CONVERTER

  double _toDouble(dynamic value) {
    if (value == null) {
      return 0;
    }

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString()) ?? 0;
  }

  // MAX Y
  double _calculateMaxY(double maxRevenue) {
    if (maxRevenue <= 0) {
      return 1000;
    }

    if (maxRevenue <= 1000) {
      return 1000;
    }

    final magnitude = math.pow(10, maxRevenue.toStringAsFixed(0).length - 1);

    final roundedMax = (maxRevenue / magnitude).ceil() * magnitude;

    return roundedMax.toDouble();
  }

  // Y INTERVAL
  double _getInterval(double maxY) {
    if (maxY <= 1000) {
      return 250;
    }

    return maxY / 4;
  }

  // X INTERVAL
  double _getXAxisInterval() {
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

  // X INTERVAL TYPE

  DateTimeIntervalType _getIntervalType() {
    // Year = Month interval
    if (selectedPeriod == AppStringsConstants.thisYearKeys ||
        selectedPeriod == AppStringsConstants.previousYearKeys) {
      return DateTimeIntervalType.months;
    }

    // Other periods = Day interval
    return DateTimeIntervalType.days;
  }

  // BOTTOM DATE TITLE

  String _formatBottomTitleFromDate(DateTime date) {
    final dateString =
        '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';

    // THIS YEAR / PREVIOUS YEAR

    if (selectedPeriod == AppStringsConstants.thisYearKeys ||
        selectedPeriod == AppStringsConstants.previousYearKeys) {
      return DateHelper.monthYear(dateString);
    }

    // THIS WEEK

    if (selectedPeriod == AppStringsConstants.thisWeekKeys) {
      return DateHelper.weekdayShort(dateString);
    }

    // MONTH / QUARTER

    return DateHelper.dayMonth(dateString);
  }

  // TOOLTIP DATE
  String _formatTooltipDate(DateTime date) {
    final dateString =
        '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';

    return DateHelper.dMy(dateString);
  }

  // Y AXIS FORMAT
  String _formatAxisValue(double value) {
    if (value == 0) {
      return '$currencyName 0';
    }

    if (value >= 1000000) {
      return '$currencyName '
          '${(value / 1000000).toStringAsFixed(1)}M';
    }

    if (value >= 1000) {
      return '$currencyName '
          '${(value / 1000).toStringAsFixed(1)}K';
    }

    return '$currencyName '
        '${value.toStringAsFixed(0)}';
  }

  // TOOLTIP AMOUNT

  String _formatAmount(num value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }

    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }

    return value.toStringAsFixed(0);
  }
}

// CHART DATA MODEL
class RevenueChartData {
  final DateTime? date;
  final double revenue;

  RevenueChartData({required this.date, required this.revenue});
}
