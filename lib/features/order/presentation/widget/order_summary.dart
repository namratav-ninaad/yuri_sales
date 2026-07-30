import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/cart/presentation/widget/summary_row.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.currency,
    required this.untaxedAmount,
    required this.vat,
    required this.total,
    required this.title,
  });

  final String currency;
  final double untaxedAmount;
  final double vat;
  final double total;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          title: title,
          fontSize: AppSizes.f16,
          fontWeight: FontWeight.w700,
        ),
        AppSizes.h16,
        SummaryRow(
          label: AppStringsConstants.untaxedAmount,
          value: '$currency $untaxedAmount',
          textColor: context.grey89,
          valueColor: context.black,
        ),
        AppSizes.h8,
        SummaryRow(
          label: AppStringsConstants.vat,
          value: '$currency $vat',
          textColor: context.grey89,
          valueColor: AppColorsConstants.green,
        ),
        AppSizes.h12,
        const CommonDivider(),
        AppSizes.h12,
        SummaryRow(
          fontWeight: FontWeight.w600,
          fontSize: AppSizes.f14,
          label: AppStringsConstants.total,
          value: '$currency $total',
          textColor: context.grey89,
          valueColor: AppColorsConstants.primaryRedColor,
        ),
      ],
    );
  }
}
