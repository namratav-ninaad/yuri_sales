import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class BuildCard extends StatelessWidget {
  const BuildCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.padding,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        color: context.greyFA,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.r12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                  title: title,
                  fontSize: AppSizes.f14,
                  fontWeight: FontWeight.w700,
                ),
                AppSizes.h4,
                CommonTextWidget(
                  title: subtitle,
                  fontSize: AppSizes.f12,
                  fontWeight: FontWeight.w500,
                  color: context.grey89,
                ),
                AppSizes.h12,
              ],
            ),
          ),
          Padding(
            padding: padding ?? const EdgeInsets.all(AppSizes.r12),
            child: child,
          ),
        ],
      ),
    );
  }
}
