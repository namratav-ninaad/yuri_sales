import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/dashboard/data/model/dashboard.dart';

class BuildTopCustomerRow extends StatelessWidget {
  const BuildTopCustomerRow({
    super.key,
    required this.customer,
    required this.index,
    required this.currencyName,
  });

  final TopCustomer customer;
  final String currencyName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        color: context.greyFA,
      ),
      child: Row(
        children: [
          // Rank number
          Expanded(
            flex: 1,
            child: Container(
              width: AppSizes.s24,
              height: AppSizes.s24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.greyF2,
                borderRadius: BorderRadius.circular(AppSizes.r4),
              ),
              child: CommonTextWidget(
                title: (index + 1).toString(),
                fontSize: AppSizes.f12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          AppSizes.w12,
          // Product name
          Expanded(
            flex: 4,
            child: CommonTextWidget(
              title: customer.name,
              fontSize: AppSizes.f12,
              fontWeight: FontWeight.w600,
            ),
          ),
          AppSizes.w12,
          // Qty
          Expanded(
            flex: 2,
            child: CommonTextWidget(
              title: customer.orders.toString(),
              fontSize: AppSizes.f12,
              fontWeight: FontWeight.w400,
            ),
          ),
          AppSizes.w12,
          // Revenue
          Expanded(
            flex: 2,
            child: CommonTextWidget(
              title: '$currencyName\t${customer.revenue.toString()}',
              fontSize: AppSizes.f12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
