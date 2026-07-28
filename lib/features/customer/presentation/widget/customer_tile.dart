import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_bg_icon_and_text.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final String value;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Expanded(
            child: CommonBgIconAndText(
              icon: icon,
              title: title,
              iconSize: AppSizes.icon20,
              radius: AppSizes.r8,
              fontWeight: FontWeight.w700,
            ),
          ),
          CommonTextWidget(
            title: value,
            color: context.black,
            fontWeight: FontWeight.w600,
            fontSize: AppSizes.f14,
          ),
          AppSizes.w12,
          CommonIconWidget(
            icon: Icons.arrow_forward_ios_outlined,
            color: context.grey89,
            size: AppSizes.icon16,
          ),
        ],
      ),
    );
  }
}
