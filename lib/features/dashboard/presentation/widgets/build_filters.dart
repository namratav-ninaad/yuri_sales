import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_date_picker.dart';
import 'package:yuri_sale/core/widgets/common_drop_down.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/core/widgets/date_helper.dart';
import 'package:yuri_sale/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:yuri_sale/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:yuri_sale/features/dashboard/presentation/bloc/dashboard_state.dart';

class BuildFilters extends StatefulWidget {
  const BuildFilters({super.key});

  @override
  State<BuildFilters> createState() => _BuildFiltersState();
}

class _BuildFiltersState extends State<BuildFilters> {
  final Map<String, String> periodLabels = {
    AppStringsConstants.todayKeys: AppStringsConstants.todayLabel,

    AppStringsConstants.yesterdayKeys: AppStringsConstants.yesterdayLabel,

    AppStringsConstants.thisWeekKeys: AppStringsConstants.thisWeekLabel,

    AppStringsConstants.thisMonthKeys: AppStringsConstants.thisMonthLabel,

    AppStringsConstants.lastMonthKeys: AppStringsConstants.lastMonthLabel,

    AppStringsConstants.thisQuarterKeys: AppStringsConstants.thisQuarterLabel,

    AppStringsConstants.thisYearKeys: AppStringsConstants.thisYearLabel,

    AppStringsConstants.previousYearKeys: AppStringsConstants.previousYearLabel,

    AppStringsConstants.customKeys: AppStringsConstants.customLabel,
  };

  final icons = [
    Icons.show_chart_rounded,
    Icons.bar_chart_rounded,
    Icons.pie_chart_rounded,
    Icons.donut_large_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final isCustom = state.period == AppStringsConstants.customKeys;

        return Column(
          children: [
            // COMPANY + SALESPERSON
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        title: AppStringsConstants.company,
                        fontSize: AppSizes.f14,
                        fontWeight: FontWeight.w700,
                      ),

                      AppSizes.h8,

                      Container(
                        height: AppSizes.s45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.r12),
                          color: context.greyFA,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.p16,
                          vertical: AppSizes.p12,
                        ),
                        child: CommonTextWidget(
                          title: state.dashboardData?.company?.name ?? '',
                          fontSize: AppSizes.f14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                AppSizes.w12,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        title: AppStringsConstants.salePerson,
                        fontSize: AppSizes.f14,
                        fontWeight: FontWeight.w700,
                      ),

                      AppSizes.h8,

                      Container(
                        width: double.infinity,
                        height: AppSizes.s45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.r12),
                          color: context.greyFA,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.p16,
                          vertical: AppSizes.p12,
                        ),
                        child: CommonTextWidget(
                          title: state.dashboardData?.salesperson?.name ?? '',
                          fontSize: AppSizes.f14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            AppSizes.h12,

            // PERIOD + CHART
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        title: AppStringsConstants.period,
                        fontSize: AppSizes.f14,
                        fontWeight: FontWeight.w700,
                      ),

                      AppSizes.h8,

                      SizedBox(
                        height: AppSizes.s45,
                        child: CommonDropdown<String>(
                          hintText: AppStringsConstants.period,
                          items: periodLabels.keys.toList(),
                          initialValue: state.period,
                          itemLabel: (key) => periodLabels[key] ?? key,
                          onChanged: (value) {
                            if (value == null) return;

                            context.read<DashboardBloc>().add(
                              ChangeDashboardPeriodEvent(value),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                AppSizes.w12,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        title: AppStringsConstants.chart,
                        fontSize: AppSizes.f14,
                        fontWeight: FontWeight.w700,
                      ),

                      AppSizes.h8,

                      Container(
                        width: double.infinity,
                        height: AppSizes.s45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.r12),
                          color: context.greyFA,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.p16,
                          vertical: AppSizes.p8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(icons.length, (index) {
                            final selected = state.chartType == index;

                            return Container(
                              width: AppSizes.s24,
                              height: AppSizes.s24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.r5,
                                ),
                                color: selected
                                    ? context.greyC8
                                    : AppColorsConstants.transparent,
                              ),
                              padding: EdgeInsets.all(AppSizes.p2),
                              margin: const EdgeInsets.only(right: AppSizes.r8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.r12,
                                ),
                                onTap: () {
                                  context.read<DashboardBloc>().add(
                                    ChangeDashboardChartEvent(index),
                                  );
                                },
                                child: CommonIconWidget(
                                  icon: icons[index],
                                  size: AppSizes.icon20,
                                  color: selected
                                      ? context.primaryRedColor
                                      : context.black,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // CUSTOM DATE FILTER
            if (isCustom) ...[
              AppSizes.h12,

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // START DATE
                  Expanded(
                    child: _buildDateField(
                      context: context,
                      title: AppStringsConstants.startDate,
                      date: state.startDate,
                      onTap: () {
                        _selectStartDate(context, state);
                      },
                    ),
                  ),

                  AppSizes.w12,

                  // END DATE
                  Expanded(
                    child: _buildDateField(
                      context: context,
                      title: AppStringsConstants.endDate,
                      date: state.endDate,
                      onTap: () {
                        _selectEndDate(context, state);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  // DATE FIELD

  Widget _buildDateField({
    required BuildContext context,
    required String title,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          title: title,
          fontSize: AppSizes.f14,
          fontWeight: FontWeight.w700,
        ),

        AppSizes.h8,

        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.r12),
          child: Container(
            width: double.infinity,
            height: AppSizes.s45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.r12),
              color: context.greyFA,
            ),
            padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
            child: Row(
              children: [
                CommonIconWidget(
                  icon: Icons.calendar_month_rounded,
                  size: AppSizes.icon20,
                  color: context.primaryRedColor,
                ),

                AppSizes.w8,

                Expanded(
                  child: CommonTextWidget(
                    title: date == null
                        ? AppStringsConstants.selectDate
                        : DateHelper.dMySlash(date.toIso8601String()),
                    fontSize: AppSizes.f14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                CommonIconWidget(
                  icon: Icons.keyboard_arrow_down_rounded,
                  size: AppSizes.icon20,
                  color: context.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // START DATE PICKER
  Future<void> _selectStartDate(
    BuildContext context,
    DashboardState state,
  ) async {
    final now = DateTime.now();

    final initialDate = state.startDate ?? DateTime(now.year, now.month, 1);

    final lastDate = state.endDate ?? now;

    final DateTime? selectedDate = await CommonDatePicker.pickDate(
      context: context,
      initialDate: initialDate.isAfter(lastDate) ? lastDate : initialDate,
      firstDate: DateTime(2020),
      lastDate: lastDate,
    );

    if (selectedDate == null) return;

    if (!context.mounted) return;

    context.read<DashboardBloc>().add(
      ChangeDashboardStartDateEvent(selectedDate),
    );
  }

  // END DATE PICKER

  Future<void> _selectEndDate(
    BuildContext context,
    DashboardState state,
  ) async {
    final now = DateTime.now();

    final initialDate = state.endDate ?? now;

    final firstDate = state.startDate ?? DateTime(2020);

    final DateTime? selectedDate = await CommonDatePicker.pickDate(
      context: context,
      initialDate: initialDate.isBefore(firstDate) ? firstDate : initialDate,
      firstDate: firstDate,
      lastDate: now,
    );

    if (selectedDate == null) return;

    if (!context.mounted) return;

    context.read<DashboardBloc>().add(
      ChangeDashboardEndDateEvent(selectedDate),
    );
  }
}
