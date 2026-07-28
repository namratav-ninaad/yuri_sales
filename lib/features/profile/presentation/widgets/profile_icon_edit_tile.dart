import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class ProfileIconEditTile extends StatelessWidget {
  const ProfileIconEditTile({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
  });

  final Function()? onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CommonIconWidget(icon: icon, color: context.black),
      title: CommonTextWidget(
        title: title,
        color: context.black,
        fontWeight: FontWeight.w700,
        fontSize: AppSizes.f14,
      ),
      onTap: onTap,
    );
  }
}