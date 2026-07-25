import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_images.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_assets_image_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({
    super.key,
    required this.name,
    required this.email,
    required this.amount,
  });

  final String name;
  final String email;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColorsConstants.primaryRedColor.withValues(alpha: 0.1),
        child: CommonAssetsImageWidget(
          imagePath: AppImagesConstants.profileIcon,
          color: AppColorsConstants.primaryRedColor,
          imageWidth: AppSizes.icon20,
          imageHeight: AppSizes.icon20,
        ),
      ),
      title: CommonTextWidget(
        title: name,
        color: AppColorsConstants.black,
        fontSize: AppSizes.f14,
        fontWeight: FontWeight.w700,
      ),

      subtitle: CommonTextWidget(
        title: email,
        color: AppColorsConstants.grey89,
        fontSize: AppSizes.f12,
        fontWeight: FontWeight.w500,
      ),
      trailing: CommonTextWidget(
        title: amount,
        color: AppColorsConstants.grey89,
        fontSize: AppSizes.f12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
