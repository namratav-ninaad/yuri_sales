import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonTextWidget(
          title: label,
          fontWeight: FontWeight.w500,
          color: isTotal
              ? AppColorsConstants.primaryRedColor
              : AppColorsConstants.grey89,
          fontSize: AppSizes.f12,
        ),
        CommonTextWidget(
          title: value,
          fontWeight: FontWeight.w400,
          color: isTotal
              ? AppColorsConstants.primaryRedColor
              : AppColorsConstants.grey89,
          fontSize: AppSizes.f12,
        ),
      ],
    );
  }
}
