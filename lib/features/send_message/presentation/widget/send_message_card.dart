import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_network_image.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/core/widgets/date_helper.dart';
import 'package:yuri_sale/features/send_message/data/model/send_message.dart';

class SendMessageCard extends StatelessWidget {
  const SendMessageCard({
    super.key,
    required this.sendMessage,
    required this.onEdit,
    required this.onDelete,
  });

  final SendMessageModel sendMessage;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  IconData getAttachmentIcon(String mimeType) {
    final type = mimeType.toLowerCase();

    if (type.contains(AppStringsConstants.pdfExtension)) {
      return Icons.picture_as_pdf;
    }

    if (type.contains(AppStringsConstants.image)) {
      return Icons.image;
    }

    if (type.contains(AppStringsConstants.word) ||
        type.contains(AppStringsConstants.document)) {
      return Icons.description;
    }

    if (type.contains(AppStringsConstants.excel) ||
        type.contains(AppStringsConstants.spreadsheet)) {
      return Icons.table_chart;
    }

    if (type.contains(AppStringsConstants.zipL)) {
      return Icons.folder_zip;
    }

    return Icons.insert_drive_file;
  }

  @override
  Widget build(BuildContext context) {
    final time = DateHelper.time(sendMessage.date);
    final day = DateHelper.monthDay(sendMessage.date);

    return Container(
      padding: const EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        // border: Border.all(color: context.greyC8.withValues(alpha: 0.5)),
        color: context.greyFA,
        boxShadow: [
          BoxShadow(
            color: context.black.withValues(alpha: 0.1),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar  + Author + Date + Menu
          Row(
            children: [
              CircleAvatar(
                radius: AppSizes.icon16,
                backgroundColor: context.primaryRedColor,
                child: CommonTextWidget(
                  title: sendMessage.author.isNotEmpty
                      ? sendMessage.author[0].toUpperCase()
                      : 'A',
                  fontSize: AppSizes.f14,
                  color: context.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSizes.w12,
              Expanded(
                child: CommonTextWidget(
                  title: sendMessage.author,
                  fontSize: AppSizes.f14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CommonTextWidget(
                title: '$day at $time',
                fontSize: AppSizes.f12,
                color: context.greyC8,
              ),
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                icon: CommonIconWidget(
                  icon: Icons.more_vert,
                  size: AppSizes.icon20,
                  color: context.black,
                ),
                onSelected: (value) {
                  if (value == AppStringsConstants.editL) onEdit();
                  if (value == AppStringsConstants.deleteL) onDelete();
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: AppStringsConstants.editL,
                    child: CommonTextWidget(
                      title: AppStringsConstants.edit,
                      fontSize: AppSizes.f14,
                    ),
                  ),
                  PopupMenuItem(
                    value: AppStringsConstants.deleteL,
                    child: CommonTextWidget(
                      fontSize: AppSizes.f14,
                      title: AppStringsConstants.delete,
                    ),
                  ),
                ],
              ),
            ],
          ),

          AppSizes.h8,

          // Body (HTML)
          Html(
            data: sendMessage.body,
            style: {
              'body': Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                fontSize: FontSize(AppSizes.f14),
                color: context.black,
              ),
              'p': Style(margin: Margins.zero, padding: HtmlPaddings.zero),
            },
          ),

          if (sendMessage.attachments.isNotEmpty) ...[
            AppSizes.h12,
            CommonTextWidget(
              title: AppStringsConstants.attachments,
              fontSize: AppSizes.f14,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.h8,
            SizedBox(
              height: 80,
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: sendMessage.attachments.length,
                separatorBuilder: (_, _) => AppSizes.w12,
                itemBuilder: (context, index) {
                  final attachment = sendMessage.attachments[index];

                  final isImage = attachment.mimetype.startsWith(
                    AppStringsConstants.imageMimeType,
                  );
                  return Column(
                    children: [
                      isImage
                          ? CommonNetworkImage(
                              imageUrl: attachment.downloadUrl,
                              height: AppSizes.image50,
                              width: AppSizes.image50,
                            )
                          : CommonIconWidget(
                              icon: getAttachmentIcon(attachment.mimetype),
                              color: context.primaryRedColor,
                              size: AppSizes.image50,
                            ),
                      AppSizes.w4,

                      Expanded(
                        child: CommonTextWidget(
                          title: attachment.name,
                          fontSize: AppSizes.f14,
                          fontWeight: FontWeight.w500,
                          overFlow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
