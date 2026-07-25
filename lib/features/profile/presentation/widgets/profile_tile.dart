import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.showDivider = true,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final bool showDivider;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: AppSizes.hS12,
          minLeadingWidth: AppSizes.hS0,
          leading: CommonIconWidget(
            icon: icon,
            size: AppSizes.icon24,
            color: AppColorsConstants.black,
          ),
          title: CommonTextWidget(
            title: title,
            color: AppColorsConstants.black,
            fontWeight: FontWeight.w500,
            fontSize: AppSizes.f14,
          ),
          trailing: const CommonIconWidget(icon: Icons.chevron_right),
          onTap: onTap,
        ),
        if (showDivider) const CommonDivider(),
      ],
    );
  }
}
