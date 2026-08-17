import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.p8),
      decoration: BoxDecoration(
        color: context.greyFA,
        boxShadow: [
          BoxShadow(
            color: context.black.withValues(alpha: 0.1),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(AppSizes.r12),
        // border: Border.all(color: context.greyC8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            title: AppStringsConstants.achievement,
            color: context.black,
            fontSize: AppSizes.f12,
            fontWeight: FontWeight.w500,
          ),
          AppSizes.h12,
          Center(
            child: SizedBox(
              height: AppSizes.chart70,
              width: AppSizes.chart70,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: AppSizes.chart70,
                    width: AppSizes.chart70,
                    child: CircularProgressIndicator(
                      value: 0.76,
                      strokeWidth: 10,
                      backgroundColor: context.greyC8,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        context.primaryRedColor,
                      ),
                    ),
                  ),

                  CommonTextWidget(
                    title: '76%',
                    color: context.black,
                    fontSize: AppSizes.f10,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
