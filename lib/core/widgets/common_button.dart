import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.title,
    this.onTap,
    this.isLoading = false,
  });

  final String title;
  final Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: AppSizes.s45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.primaryRedColor,
          borderRadius: BorderRadius.circular(AppSizes.r12),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CommonCircularProgressIndicator(
                  color: AppColorsConstants.white,
                ),
              )
            : CommonTextWidget(
                title: title,
                color: AppColorsConstants.white,
                fontSize: AppSizes.f16,
                fontWeight: FontWeight.w700,
              ),
      ),
    );
  }
}
