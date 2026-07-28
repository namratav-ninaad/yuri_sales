import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
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
          color: borderColor ?? context.primaryRedColor,
        ),
        borderRadius: BorderRadius.circular(AppSizes.r8),
        color:
            backgroundColor ??
            context.primaryRedColor.withValues(alpha: 0.1),
      ),
      child: CommonTextWidget(
        title: title,
        color: textColor ?? context.primaryRedColor,
        fontWeight: FontWeight.w500,
        fontSize: fontSize ?? AppSizes.f12,
        overFlow: TextOverflow.ellipsis,
      ),
    );
  }
}
