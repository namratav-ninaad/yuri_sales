import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class ActivityActionButton extends StatelessWidget {
  const ActivityActionButton({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.r4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonIconWidget(
            icon: icon,
            size: AppSizes.icon16,
            color: context.grey89,
          ),
          AppSizes.w4,
          CommonTextWidget(
            title: title,
            fontWeight: FontWeight.w500,
            fontSize: AppSizes.f14,
            color: context.grey89,
          ),
        ],
      ),
    );
  }
}