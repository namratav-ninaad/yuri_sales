import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';

class CommonAssetsImageWidget extends StatelessWidget {
  const CommonAssetsImageWidget({
    super.key,
    this.imageHeight = AppSizes.image180,
    this.imageWidth = AppSizes.image180,
    required this.imagePath,
    this.color,
  });

  final double imageHeight;
  final double imageWidth;
  final String imagePath;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: imageHeight,
      width: imageWidth,
      color: color,
    );
  }
}
