import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/activity/data/model/activity.dart';
import 'package:yuri_sale/features/activity/presentation/widget/activity_action_button.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    required this.activity,
    this.onMarkDone,
    this.onEdit,
    this.onCancel,
  });

  final ActivityItemModel activity;

  final VoidCallback? onMarkDone;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  String get dueLabel {
    final due = DateTime.parse(activity.deadline);

    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final deadline = DateTime(due.year, due.month, due.day);

    final diff = deadline.difference(today).inDays;

    if (diff == 0) return AppStringsConstants.today;
    if (diff == -1) return AppStringsConstants.yesterday;
    if (diff == 1) return AppStringsConstants.tomorrow;
    if (diff > 1) {
      return '${AppStringsConstants.dueIn} $diff ${AppStringsConstants.days}';
    }

    return '${-diff} ${AppStringsConstants.days} ${AppStringsConstants.overdue}';
  }

  Color get dueColor {
    if (dueLabel == AppStringsConstants.today) {
      return AppColorsConstants.orange;
    }

    if (dueLabel == AppStringsConstants.yesterday ||
        dueLabel.contains(AppStringsConstants.overdue)) {
      return AppColorsConstants.red;
    }

    return AppColorsConstants.green;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        // border: Border.all(color: context.greyC8),
        color: context.greyFA,
        boxShadow: [
          BoxShadow(
            color: context.black.withValues(alpha: 0.1),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Timeline
          Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: context.primaryRedColor,
                    child: CommonTextWidget(
                      title: activity.assignedTo?[0].toUpperCase() ?? '',
                      fontWeight: FontWeight.w500,
                      fontSize: AppSizes.f12,
                      color: context.white,
                    ),
                  ),

                  Positioned(
                    right: -5,
                    bottom: -5,
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.p2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dueColor,
                        border: Border.all(
                          color: AppColorsConstants.white,
                          width: 2,
                        ),
                      ),
                      child: CommonIconWidget(
                        icon: activity.activityType == AppStringsConstants.todo
                            ? Icons.check
                            : activity.activityType == AppStringsConstants.call
                            ? Icons.call
                            : Icons.email,
                        size: AppSizes.icon14,
                        color: AppColorsConstants.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppSizes.w12,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                  title: activity.assignedTo ?? '',
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.f14,
                ),
                AppSizes.h8,
                Row(
                  children: [
                    CommonTextWidget(
                      title: '$dueLabel : ',
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.f14,
                      color: dueColor,
                    ),
                    CommonTextWidget(
                      title: activity.summary,
                      fontWeight: FontWeight.w500,
                      fontSize: AppSizes.f14,
                      color: context.grey89,
                    ),
                  ],
                ),

                if (activity.note != null && activity.note!.isNotEmpty) ...[
                  AppSizes.h12,
                  CommonTextWidget(
                    title: AppStringsConstants.originalNote,
                    fontWeight: FontWeight.w600,
                    fontSize: AppSizes.f14,
                  ),

                  AppSizes.h4,
                  // Body (HTML)
                  Html(
                    data: activity.note,
                    style: {
                      'body': Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        fontSize: FontSize(AppSizes.f14),
                        color: context.black,
                      ),
                      'p': Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                    },
                  ),
                ],
                AppSizes.h12,
                Row(
                  children: [
                    ActivityActionButton(
                      icon: Icons.check_outlined,
                      title: AppStringsConstants.markDone,
                      onTap: onMarkDone,
                    ),

                    AppSizes.w12,

                    ActivityActionButton(
                      icon: Icons.edit_outlined,
                      title: AppStringsConstants.edit,
                      onTap: onEdit,
                    ),

                    AppSizes.w12,

                    ActivityActionButton(
                      icon: Icons.close,
                      title: AppStringsConstants.cancel,
                      onTap: onCancel,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
