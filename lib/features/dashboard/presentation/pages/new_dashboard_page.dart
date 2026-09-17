import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_logo_image.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/dashboard/data/model/dashboard.dart';
import 'package:yuri_sale/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:yuri_sale/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:yuri_sale/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_bar_chart.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_card.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_category_card.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_country_state_card.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_donut_chart.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_filters.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_line_chart.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_pie_chart.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_table_header.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_product_row.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_top_customer_row.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/metric_card.dart';

class NewDashboardPage extends StatefulWidget {
  const NewDashboardPage({super.key});

  @override
  State<NewDashboardPage> createState() => _NewDashboardPageState();
}

class _NewDashboardPageState extends State<NewDashboardPage> {
  @override
  void initState() {
    context.read<DashboardBloc>().add(
      FetchDashboardEvent(AppStringsConstants.thisYearKeys),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double childAspectRatio;

    if (screenWidth < 600) {
      // Mobile
      childAspectRatio = 1.25;
    } else if (screenWidth < 900) {
      // Tablet
      childAspectRatio = 1.6;
    } else {
      // Desktop
      childAspectRatio = 2.0;
    }
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        leading: AppSizes.h0,
        title: AppStringsConstants.dashboard,
        icon: CommonLogoImage(
          imageWidth: AppSizes.image120,
          imageHeight: AppSizes.image80,
        ),
      ),

      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          final dashboard = state.dashboardData;
          final topProducts = state.dashboardData?.charts?.topProducts ?? [];
          final leastProducts =
              state.dashboardData?.charts?.leastProducts ?? [];
          final topCustomers = state.dashboardData?.charts?.topCustomers ?? [];

          return state.isLoading
              ? Center(child: CommonCircularProgressIndicator())
              : state.dashboardData == null
              ? Center(
                  child: CommonEmptyText(
                    title: AppStringsConstants.noDashboardData,
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.all(AppSizes.p24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildFilters(),
                      AppSizes.h24,
                      if (dashboard != null)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: dashboard.metrics.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: screenWidth < 600 ? 2 : 4,
                                crossAxisSpacing: AppSizes.p12,
                                mainAxisSpacing: AppSizes.p12,
                                childAspectRatio: childAspectRatio,
                              ),
                          itemBuilder: (context, index) {
                            return MetricCard(metric: dashboard.metrics[index]);
                          },
                        ),
                      AppSizes.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget(
                                  title: AppStringsConstants.revenueTrend,
                                  fontSize: AppSizes.f14,
                                  fontWeight: FontWeight.w700,
                                ),
                                AppSizes.h4,
                                CommonTextWidget(
                                  title: AppStringsConstants.revenueTrend,
                                  fontSize: AppSizes.f12,
                                  fontWeight: FontWeight.w500,
                                  color: context.grey89,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AppSizes.h12,
                      SizedBox(
                        height: 235,
                        width: double.infinity,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: switch (state.chartType) {
                            0 => BuildLineChart(
                              selectedPeriod: state.period,
                              currencyName:
                                  state.dashboardData!.company?.currencyName ??
                                  '',
                              revenueTrend:
                                  state.dashboardData!.charts?.revenueTrend ??
                                  [],
                            ),
                            1 => BuildBarChart(
                              currencyName:
                                  state.dashboardData!.company?.currencyName ??
                                  '',
                              revenueTrend:
                                  state.dashboardData!.charts?.revenueTrend ??
                                  [],
                              selectedPeriod: state.period,
                            ),
                            2 => BuildPieChart(
                              currencyName:
                                  state.dashboardData!.company?.currencyName ??
                                  '',
                              selectedPeriod: state.period,
                              revenueTrend:
                                  state.dashboardData!.charts?.revenueTrend ??
                                  [],
                            ),
                            3 => BuildDonutChart(
                              currencyName:
                                  state.dashboardData!.company?.currencyName ??
                                  '',
                              selectedPeriod: state.period,
                              revenueTrend:
                                  state.dashboardData!.charts?.revenueTrend ??
                                  [],
                            ),
                            _ => BuildLineChart(
                              selectedPeriod: state.period,
                              currencyName:
                                  state.dashboardData!.company?.currencyName ??
                                  '',
                              revenueTrend:
                                  state.dashboardData!.charts?.revenueTrend ??
                                  [],
                            ),
                          },
                        ),
                      ),
                      AppSizes.h24,
                      BuildCountryStateCard(
                        currencyName:
                            state.dashboardData!.company?.currencyName ?? '',
                        items:
                            state.dashboardData!.charts?.salesByCountry ?? [],
                      ),
                      AppSizes.h24,
                      BuildCountryStateCard(
                        currencyName:
                            state.dashboardData!.company?.currencyName ?? '',
                        title: AppStringsConstants.salesByState,
                        subtitle: AppStringsConstants.revenueDistribution,
                        items: state.dashboardData!.charts?.salesByState ?? [],
                      ),
                      AppSizes.h24,
                      BuildCategoryCard(
                        currencyName:
                            state.dashboardData!.company?.currencyName ?? '',
                        title: AppStringsConstants.salesByCategory,
                        subtitle: AppStringsConstants.revenueDistributionMsg,
                        items:
                            state.dashboardData!.charts?.salesByCategory ?? [],
                      ),
                      AppSizes.h24,
                      BuildCard(
                        padding: EdgeInsets.zero,
                        title: AppStringsConstants.topProduct,
                        subtitle: AppStringsConstants.bestPerformingProducts,
                        child: Column(
                          children: [
                            BuildTableHeader(
                              titles: [
                                AppStringsConstants.hashtag,
                                AppStringsConstants.product,
                                AppStringsConstants.brand,
                                AppStringsConstants.qty,
                                AppStringsConstants.revenue,
                              ],
                              titleExpanded: AppStringsConstants.product,
                            ),
                            AppSizes.h8,
                            if (topProducts.isEmpty)
                              const CommonEmptyText(
                                title: AppStringsConstants.noTopProductData,
                              )
                            else
                              ...topProducts.asMap().entries.map(
                                (entry) => BuildProductRow(
                                  currencyName:
                                      state
                                          .dashboardData!
                                          .company
                                          ?.currencyName ??
                                      '',
                                  index: entry.key,
                                  product: entry.value,
                                  isBrandShow: true,
                                ),
                              ),
                          ],
                        ),
                      ),
                      AppSizes.h24,
                      BuildCard(
                        padding: EdgeInsets.zero,
                        title: AppStringsConstants.leastPerformingProducts,
                        subtitle: AppStringsConstants.lowestRevenueMsg,
                        child: Column(
                          children: [
                            // Header
                            BuildTableHeader(
                              titles: [
                                AppStringsConstants.hashtag,
                                AppStringsConstants.product,
                                AppStringsConstants.qty,
                                AppStringsConstants.revenue,
                              ],
                              titleExpanded: AppStringsConstants.product,
                            ),
                            AppSizes.h8,
                            if (leastProducts.isEmpty)
                              const CommonEmptyText(
                                title: AppStringsConstants.noLeastProductData,
                              )
                            else
                              ...leastProducts.asMap().entries.map(
                                (entry) => BuildProductRow(
                                  currencyName:
                                      state
                                          .dashboardData!
                                          .company
                                          ?.currencyName ??
                                      '',
                                  index: entry.key,
                                  product: entry.value,
                                ),
                              ),
                          ],
                        ),
                      ),
                      AppSizes.h24,
                      BuildCard(
                        padding: EdgeInsets.zero,
                        title: AppStringsConstants.topCustomers,
                        subtitle: AppStringsConstants.highestRevenueCustomers,
                        child: Column(
                          children: [
                            // Header
                            BuildTableHeader(
                              titles: [
                                AppStringsConstants.hashtag,
                                AppStringsConstants.customer,
                                AppStringsConstants.orders,
                                AppStringsConstants.revenue,
                              ],
                              titleExpanded: AppStringsConstants.customer,
                            ),
                            AppSizes.h8,
                            if (topCustomers.isEmpty)
                              const CommonEmptyText(
                                title: AppStringsConstants.noTopCustomerData,
                              )
                            else
                              ...topCustomers.asMap().entries.map(
                                (entry) => BuildTopCustomerRow(
                                  currencyName:
                                      state
                                          .dashboardData!
                                          .company
                                          ?.currencyName ??
                                      '',
                                  index: entry.key,
                                  customer: entry.value,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
