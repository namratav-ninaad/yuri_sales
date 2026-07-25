import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';

class CommonCircleAvatar extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final VoidCallback? onEditTap;

  const CommonCircleAvatar({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        (imageFile != null) || (imageUrl != null && imageUrl!.isNotEmpty);

    return Stack(
      children: [
        CircleAvatar(
          radius: AppSizes.icon50,
          backgroundColor: AppColorsConstants.greyF2,
          backgroundImage: _getBackgroundImage(),
          child: !hasImage
              ? CommonIconWidget(
                  icon: Icons.person,
                  size: AppSizes.icon60,
                  color: AppColorsConstants.black,
                )
              : null,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: onEditTap,
            child: Container(
              padding: const EdgeInsets.all(AppSizes.p4),
              decoration: BoxDecoration(
                color: AppColorsConstants.primaryRedColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppColorsConstants.white),
              ),
              child: const CommonIconWidget(
                icon: Icons.edit,
                size: AppSizes.icon14,
                color: AppColorsConstants.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider<Object>? _getBackgroundImage() {
    if (imageFile != null) {
      return FileImage(imageFile!);
    }
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return NetworkImage(imageUrl!);
    }
    return null;
  }
}
