import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.p8),
      decoration: BoxDecoration(
        color: AppColorsConstants.white,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: AppColorsConstants.greyC8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            title: AppStringsConstants.achievement,
            color: AppColorsConstants.black,
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
                      backgroundColor: AppColorsConstants.greyC8,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColorsConstants.primaryRedColor,
                      ),
                    ),
                  ),

                  CommonTextWidget(
                    title: '76%',
                    color: AppColorsConstants.black,
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
