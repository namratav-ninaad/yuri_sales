import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key,
    required this.title,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
  });

  final String title;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.p4,
        horizontal: AppSizes.p8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? AppColorsConstants.primaryRedColor,
        ),
        borderRadius: BorderRadius.circular(AppSizes.r8),
        color:
            backgroundColor ??
            AppColorsConstants.primaryRedColor.withValues(alpha: 0.1),
      ),
      child: CommonTextWidget(
        title: title,
        color: textColor ?? AppColorsConstants.primaryRedColor,
        fontWeight: FontWeight.w500,
        fontSize: fontSize ?? AppSizes.f12,
      ),
    );
  }
}
