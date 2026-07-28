import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? textColor;
  final Color? valueColor;
  final FontWeight? fontWeight;
  final double? fontSize;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.textColor,
    this.valueColor,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonTextWidget(
          title: label,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: textColor ?? context.grey89,
          fontSize: fontSize ?? AppSizes.f12,
        ),
        AppSizes.w8,
        Expanded(
          child: CommonTextWidget(
            textAlign: TextAlign.right,
            title: value,
            fontWeight: fontWeight ?? FontWeight.w400,
            color: valueColor ?? context.grey89,
            fontSize: fontSize ?? AppSizes.f12,
          ),
        ),
      ],
    );
  }
}
