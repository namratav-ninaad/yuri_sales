import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_outline_button.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class AddAttachmentBottomSheet extends StatelessWidget {
  final String title;
  final Function(List<String> files) onFilesSelected;

  const AddAttachmentBottomSheet({
    super.key,
    required this.title,
    required this.onFilesSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSizes.p24,
        right: AppSizes.p24,
        top: AppSizes.p24,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSizes.p32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonTextWidget(
            title: '${AppStringsConstants.add} $title',
            fontSize: AppSizes.f16,
            fontWeight: FontWeight.w700,
            color: context.black,
          ),
          AppSizes.h24,
          CommonButton(
            title: AppStringsConstants.browseFiles,
            onTap: () async {
              final result = await FilePicker.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
              );

              if (result.isNotEmpty) {
                final paths = result
                    .map((file) => file.path)
                    .whereType<String>()
                    .toList();

                onFilesSelected(paths);
                AppRoutes.pop();
              }
            },
          ),
          AppSizes.h12,
          CommonOutlineButton(
            title: AppStringsConstants.takePhoto,
            onTap: () async {
              final picker = ImagePicker();
              final images = await picker.pickMultiImage();
              if (images.isNotEmpty) {
                final paths = images.map((e) => e.path).toList();
                onFilesSelected(paths);
                AppRoutes.pop();
              }
            },
          ),
          AppSizes.h12,
          CommonOutlineButton(
            title: 'Cancel',
            onTap: () => AppRoutes.pop(),
            textColor: context.grey89,
            borderColor: context.greyC8,
          ),
        ],
      ),
    );
  }
}
