import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({super.key, required this.title, required this.icon, required this.value});

  final String title;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(AppSizes.p4),
          decoration: BoxDecoration(
            color: AppColorsConstants.primaryRedColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSizes.r8),
          ),
          child: Icon(
            icon,
            color: AppColorsConstants.primaryRedColor,
            size: AppSizes.icon24,
          ),
        ),
        AppSizes.w12,
        Expanded(
          child: CommonTextWidget(
            title: title,
            color: AppColorsConstants.black,
            fontWeight: FontWeight.w700,
            fontSize: AppSizes.f14,
          ),
        ),
        CommonTextWidget(
          title: value,
          color: AppColorsConstants.black,
          fontWeight: FontWeight.w600,
          fontSize: AppSizes.f14,
        ),
        AppSizes.w12,
        CommonIconWidget(
          icon: Icons.arrow_forward_ios_outlined,
          color: AppColorsConstants.grey89,
          size: AppSizes.icon16,
        ),
      ],
    );
  }
}
