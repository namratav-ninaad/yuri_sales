import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/core/widgets/date_helper.dart';
import 'package:yuri_sale/features/customer/data/model/note.dart';
import 'package:yuri_sale/features/customer/presentation/widget/tag_widget.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        // border: Border.all(color: context.greyC8),
        color: context.white,
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
          Row(
            children: [
              CircleAvatar(
                radius: AppSizes.icon14,
                backgroundColor: context.primaryRedColor.withValues(alpha: 0.1),
                child: Icon(
                  Icons.person,
                  color: context.primaryRedColor,
                  size: AppSizes.icon14,
                ),
              ),
              AppSizes.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      title: note.title,
                      color: context.black,
                      fontWeight: FontWeight.w700,
                      fontSize: AppSizes.f14,
                    ),
                    CommonTextWidget(
                      title: note.time,
                      color: context.grey89,
                      fontWeight: FontWeight.w500,
                      fontSize: AppSizes.f10,
                    ),
                  ],
                ),
              ),

              TagWidget(
                title: note.label,
                fontSize: AppSizes.f10,
                borderColor: AppColorsConstants.transparent,
                backgroundColor: note.labelColor.withValues(alpha: 0.1),
                textColor: note.labelColor,
              ),
            ],
          ),
          AppSizes.h4,

          if (note.type.isText)
            CommonTextWidget(
              title: note.content,
              fontSize: AppSizes.f12,
              fontWeight: FontWeight.w400,
              color: context.grey89,
            )
        /*  else if (note.type.isVoice)
            Row(
              children: [
                CommonIconWidget(
                  icon: Icons.play_circle_fill_outlined,
                  size: AppSizes.icon24,
                  color: context.black,
                ),
                AppSizes.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppStringsConstants.voiceMessage,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        note.duration ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            )*/
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                  title: AppStringsConstants.followUpDate,
                  fontSize: AppSizes.f12,
                  fontWeight: FontWeight.w400,
                  color: context.grey89,
                ),
                Row(
                  children: [
                    CommonIconWidget(
                      icon: Icons.calendar_month_outlined,
                      color: context.black,
                      size: AppSizes.icon20,
                    ),
                    AppSizes.w12,

                    CommonTextWidget(
                      title: note.followUpDate != null
                          ? DateHelper.dMy(note.followUpDate!.toIso8601String())
                          : DateHelper.dMy(DateTime.now().toIso8601String()),

                      fontSize: AppSizes.f12,
                      fontWeight: FontWeight.w400,
                      color: context.black,
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
