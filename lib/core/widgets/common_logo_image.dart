import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_images.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_assets_image_widget.dart';

class CommonLogoImage extends StatelessWidget {
  const CommonLogoImage({
    super.key,
    this.imageHeight = AppSizes.image120,
    this.imageWidth = AppSizes.image180,
  });

  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return CommonAssetsImageWidget(
      imagePath: AppImagesConstants.logoIcon,
      imageHeight: imageHeight,
      imageWidth: imageWidth,
    );
  }
}
