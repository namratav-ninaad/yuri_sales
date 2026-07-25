import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_assets_image_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class TitleIconCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isTopImageShow;
  final String imagePath;

  const TitleIconCard({
    super.key,
    required this.title,
    required this.value,
    this.isTopImageShow = false, required this.imagePath,
  });

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isTopImageShow)
            Align(
              alignment: Alignment.center,
              child: Container(
                width: AppSizes.icon40,
                height: AppSizes.icon40,
                padding: const EdgeInsets.all(AppSizes.p8),
                margin: EdgeInsets.only(bottom: AppSizes.p12),
                decoration: BoxDecoration(
                  color: AppColorsConstants.primaryRedColor.withValues(
                    alpha: 0.1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CommonAssetsImageWidget(
                  imagePath: imagePath,
                  color: AppColorsConstants.primaryRedColor,
                  imageHeight: AppSizes.icon32,
                  imageWidth: AppSizes.icon32,
                ),
              ),
            ),

          CommonTextWidget(
            title: title,
            color: AppColorsConstants.black,
            fontSize: AppSizes.f10,
            fontWeight: FontWeight.w500,
          ),
          AppSizes.h8,
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget(
                  title: value,
                  color: AppColorsConstants.black,
                  fontSize: AppSizes.f14,
                  fontWeight: FontWeight.w700,
                ),
                AppSizes.w4,
                if (!isTopImageShow)
                  Container(
                    width: AppSizes.icon22,
                    height: AppSizes.icon22,
                    padding: const EdgeInsets.all(AppSizes.p4),
                    decoration: BoxDecoration(
                      color: AppColorsConstants.primaryRedColor.withValues(
                        alpha: 0.1,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CommonAssetsImageWidget(
                      imagePath: imagePath,
                      color: AppColorsConstants.primaryRedColor,
                      imageHeight: AppSizes.icon16,
                      imageWidth: AppSizes.icon16,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
