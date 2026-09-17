import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';

class CommonIconWidget extends StatelessWidget {
  const CommonIconWidget({
    super.key,
    required this.icon,
    this.size,
    this.color,
    this.onTap,
  });

  final IconData icon;
  final double? size;
  final Color? color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Icon(icon, size: size ?? AppSizes.icon24, color: color),
    );
  }
}
