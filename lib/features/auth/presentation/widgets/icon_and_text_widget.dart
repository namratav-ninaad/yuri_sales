import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_images.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_assets_image_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class IconAndTextWidget extends StatelessWidget {
  const IconAndTextWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.p8),
      child: Row(
        children: [
          CommonAssetsImageWidget(
            imagePath: AppImagesConstants.checkMarkIcon,
            imageWidth: AppSizes.icon16,
            imageHeight: AppSizes.icon16,
          ),
          AppSizes.w12,
          CommonTextWidget(
            title: title,
            color: AppColorsConstants.grey89,
            fontSize: AppSizes.f12,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
