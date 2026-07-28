import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/features/cart/presentation/widget/summary_row.dart';

class CartSummary extends StatelessWidget {
  final String subtotal;
  final String vat;
  final String total;

  const CartSummary({
    super.key,
    required this.subtotal,
    required this.vat,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryRow(
          label: AppStringsConstants.subtotal,
          value: subtotal.toString(),
        ),
        AppSizes.h4,
        SummaryRow(label: AppStringsConstants.vat, value: vat.toString()),
        AppSizes.h12,
        CommonDivider(),
        AppSizes.h12,
        SummaryRow(
          label: AppStringsConstants.total,
          value: total.toString(),
          textColor: context.primaryRedColor,
          valueColor: context.primaryRedColor,
        ),
      ],
    );
  }
}
