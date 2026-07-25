import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class CommonEmptyText extends StatelessWidget {
  const CommonEmptyText({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CommonTextWidget(
        title: title,
        fontSize: AppSizes.f16,
        fontWeight: FontWeight.w700,
        color: AppColorsConstants.black,
      ),
    );
  }
}
