import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class BuildLegendItem extends StatelessWidget {
  const BuildLegendItem({super.key, required this.color, required this.title});

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSizes.s12,
          height: AppSizes.s12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppSizes.r4),
          ),
        ),
        AppSizes.w8,
        CommonTextWidget(
          title: title,
          fontSize: AppSizes.f12,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
