import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/features/dashboard/data/model/dashboard.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_card.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/build_progress_row.dart';

class BuildCategoryCard extends StatelessWidget {
  const BuildCategoryCard({
    super.key,
    required this.items,
    this.title,
    this.subtitle,
    required this.currencyName,
  });

  final List<SalesByCategory> items;
  final String? title;
  final String? subtitle;
  final String currencyName;

  @override
  Widget build(BuildContext context) {
    return BuildCard(
      title: title ?? AppStringsConstants.salesByCountry,
      subtitle: subtitle ?? AppStringsConstants.revenueDistribution,
      child: items.isEmpty
          ? Center(
              child: CommonEmptyText(
                title: AppStringsConstants.noCountrySalesData,
              ),
            )
          : Column(
              children: items
                  .map(
                    (item) => BuildProgressRow(
                      title: item.categoryName,
                      amount: item.amount,
                      percentage: item.percentage,
                      currencyName: currencyName,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
