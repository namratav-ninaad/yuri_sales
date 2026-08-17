/*
import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class BuildAttachmentItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final int fileCount;

  const BuildAttachmentItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.fileCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.r8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.p8),
        child: Row(
          children: [
            CommonIconWidget(icon: icon, color: context.grey89),
            AppSizes.w12,
            Expanded(
              child: CommonTextWidget(
                title: title,
                fontSize: AppSizes.f14,
                color: context.black,
              ),
            ),
            if (fileCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.p12,
                  vertical: AppSizes.p8,
                ),
                decoration: BoxDecoration(
                  color: context.primaryRedColor.withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                ),
                child: CommonTextWidget(
                  title: '$fileCount',
                  fontSize: AppSizes.f12,
                  color: context.primaryRedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            AppSizes.w8,
            CommonIconWidget(
              icon: fileCount > 0
                  ? Icons.file_download_outlined
                  : Icons.arrow_forward_ios_outlined,
              size: AppSizes.icon20,
              color: context.grey89,
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/customer/domain/entities/create_customer_data.dart';

class BuildAttachmentItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final List<AttachmentData> attachments;
  final Function(AttachmentData)? onRemove;

  const BuildAttachmentItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.attachments = const [],
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        // border: Border.all(color: context.greyC8),
        color: context.greyFA,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Add Button
          Row(
            children: [
              CommonIconWidget(icon: icon, color: context.grey89),
              AppSizes.w12,
              Expanded(
                child: CommonTextWidget(
                  title: title,
                  fontSize: AppSizes.f14,
                  color: context.black,
                ),
              ),

              if (onTap != null)
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.p12,
                      vertical: AppSizes.p4,
                    ),
                    decoration: BoxDecoration(
                      color: context.primaryRedColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSizes.r20),
                    ),
                    child: Row(
                      children: [
                        CommonIconWidget(
                          icon: Icons.add,
                          size: AppSizes.icon14,
                          color: context.primaryRedColor,
                        ),
                        AppSizes.w4,
                        CommonTextWidget(
                          title: AppStringsConstants.add,
                          color: context.primaryRedColor,
                          fontSize: AppSizes.f12,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          AppSizes.h12,

          // Show Selected Attachments
          if (attachments.isNotEmpty)
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: attachments.length,
                itemBuilder: (context, index) {
                  final attachment = attachments[index];
                  final isImage = attachment.mimetype.startsWith(
                    AppStringsConstants.imageMimeType,
                  );
                  final isPdf =
                      attachment.mimetype == AppStringsConstants.pdfMimeType;

                  return Padding(
                    padding: const EdgeInsets.only(right: AppSizes.p12),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: AppSizes.image80,
                              height: AppSizes.image80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.r12,
                                ),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.r12,
                                ),
                                child: isImage
                                    ? Image.memory(
                                        base64Decode(attachment.content),
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, _, _) =>
                                            const CommonIconWidget(
                                              icon: Icons.broken_image,
                                              size: AppSizes.icon40,
                                            ),
                                      )
                                    : isPdf
                                    ? const CommonIconWidget(
                                        icon: Icons.picture_as_pdf,
                                        color: AppColorsConstants.red,
                                        size: AppSizes.icon40,
                                      )
                                    : const CommonIconWidget(
                                        icon: Icons.insert_drive_file,
                                        color: AppColorsConstants.blue,
                                        size: AppSizes.icon40,
                                      ),
                              ),
                            ),
                            AppSizes.h4,
                            CommonTextWidget(
                              title: attachment.filename.length > 15
                                  ? "${attachment.filename.substring(0, 12)}..."
                                  : attachment.filename,
                              fontSize: AppSizes.f12,
                              color: context.black,
                              textAlign: TextAlign.center,
                              overFlow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        // Close / Remove Button
                        Positioned(
                          top: -8,
                          right: -8,
                          child: GestureDetector(
                            onTap: () => onRemove?.call(attachment),
                            child: Container(
                              padding: const EdgeInsets.all(AppSizes.p4),
                              decoration: BoxDecoration(
                                color: context.white,
                                shape: BoxShape.circle,
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
                },
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.p12),
              child: CommonTextWidget(
                title: AppStringsConstants.attachmentAddMsg,
                color: context.grey89,
                fontSize: AppSizes.f14,
              ),
            ),
        ],
      ),
    );
  }
}
