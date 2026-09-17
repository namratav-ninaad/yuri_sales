import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class CommonBgIconAndText extends StatelessWidget {
  const CommonBgIconAndText({
    super.key,
    required this.icon,
    required this.title,
    this.iconSize,
    this.radius,
    this.fontWeight,
    this.fontSize,
  });

  final IconData icon;
  final String title;
  final double? iconSize;
  final double? radius;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(AppSizes.p6),
          decoration: BoxDecoration(
            color: context.primaryRedColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(radius ?? AppSizes.r5),
          ),
          child: CommonIconWidget(
            icon: icon,
            color: context.primaryRedColor,
            size: iconSize ?? AppSizes.icon20,
          ),
        ),
        if (title.isNotEmpty) ...[
          AppSizes.w8,
          Expanded(
            child: CommonTextWidget(
              title: title,
              fontSize: fontSize ?? AppSizes.f14,
              fontWeight: fontWeight ?? FontWeight.w600,
            ),
           ),
        ],
      ],
    );
  }
}
