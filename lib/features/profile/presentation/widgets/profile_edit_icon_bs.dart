import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/features/profile/presentation/widgets/profile_icon_edit_tile.dart';

class ProfileEditIconBs extends StatelessWidget {
  const ProfileEditIconBs({super.key, required this.onTap});

  final Function(ImageSource) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProfileIconEditTile(
          icon: Icons.photo_camera,
          title: AppStringsConstants.camera,
          onTap: () => onTap.call(ImageSource.camera),
        ),
        CommonDivider(),
        ProfileIconEditTile(
          icon: Icons.photo_library,
          title: AppStringsConstants.gallery,
          onTap: () => onTap(ImageSource.gallery),
        ),
      ],
    );
  }
}
