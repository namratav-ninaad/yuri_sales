import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class AttachmentItem extends StatelessWidget {
  const AttachmentItem({
    super.key,
    required this.attachment,
    required this.onRemove,
  });

  final dynamic attachment;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final isImage = attachment.mimetype.startsWith(
      AppStringsConstants.imageMimeType,
    );

    final isPdf =
        attachment.mimetype == AppStringsConstants.pdfMimeType;

    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.p12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AppSizes.image80,
                height: AppSizes.image80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                  child: _buildPreview(isImage, isPdf),
                ),
              ),
              AppSizes.h4,
              SizedBox(
                width: AppSizes.image80,
                child: CommonTextWidget(
                  title: attachment.name.length > 15
                      ? '${attachment.name.substring(0, 12)}...'
                      : attachment.name,
                  fontSize: AppSizes.f12,
                  color: context.black,
                  textAlign: TextAlign.center,
                  overFlow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          Positioned(
            top: -6,
            right: -6,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(AppSizes.p4),
                decoration: BoxDecoration(
                  color: context.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: CommonIconWidget(
                  icon: Icons.close,
                  size: AppSizes.icon16,
                  color: context.primaryRedColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(bool isImage, bool isPdf) {
    if (isImage) {
      return Image.memory(
        base64Decode(attachment.content),
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) {
          return const Center(
            child: CommonIconWidget(
              icon: Icons.broken_image,
              size: AppSizes.icon40,
            ),
          );
        },
      );
    }

    if (isPdf) {
      return const Center(
        child: CommonIconWidget(
          icon: Icons.picture_as_pdf,
          color: AppColorsConstants.red,
          size: AppSizes.icon40,
        ),
      );
    }

    return const Center(
      child: CommonIconWidget(
        icon: Icons.insert_drive_file,
        color: AppColorsConstants.blue,
        size: AppSizes.icon40,
      ),
    );
  }
}