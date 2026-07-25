import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_images.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_assets_image_widget.dart';

class CommonLogoImage extends StatelessWidget {
  const CommonLogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.icon100,
      height: AppSizes.icon100,
      decoration: BoxDecoration(
        color: AppColorsConstants.primaryRedColor,
        borderRadius: BorderRadius.circular(AppSizes.f20),
      ),
      child: CommonAssetsImageWidget(imagePath: AppImagesConstants.logoIcon),
    );
  }
}
