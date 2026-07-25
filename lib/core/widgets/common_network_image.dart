import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';

class CommonNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;

  const CommonNetworkImage({super.key, this.imageUrl, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return CommonIconWidget(
        icon: Icons.image_outlined,
        size: height ?? AppSizes.icon24,
        color: AppColorsConstants.greyC8,
      );
    }
    return Image.network(
      imageUrl!,
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const CommonIconWidget(icon: Icons.broken_image),
    );
  }
}
