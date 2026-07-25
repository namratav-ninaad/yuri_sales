import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.onTap});

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonTextWidget(
          title: title,
          color: AppColorsConstants.black,
          fontSize: AppSizes.f16,
          fontWeight: FontWeight.w700,
        ),

        GestureDetector(
          onTap: onTap,
          child: CommonTextWidget(
            title: AppStringsConstants.viewAll,
            color: AppColorsConstants.primaryRedColor,
            fontSize: AppSizes.f14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
