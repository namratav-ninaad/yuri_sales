import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_bg_icon_and_text.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/dashboard/data/model/dashboard.dart';

class MetricCard extends StatelessWidget {
  final DashboardMetric metric;

  const MetricCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        color: context.greyFA,
        borderRadius: BorderRadius.circular(AppSizes.r12),
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
          CommonBgIconAndText(
            fontSize: AppSizes.f12,
            icon: metric.icon,
            title: metric.title,
            iconSize: AppSizes.icon16,
          ),
          AppSizes.h8,
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonTextWidget(
                  title: metric.value,
                  fontSize: AppSizes.f16,
                  fontWeight: FontWeight.w700,
                ),
                if (metric.secondary != null) ...[
                  AppSizes.h4,
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSizes.p4),
                    child: CommonTextWidget(
                      title: metric.secondary!,
                      fontSize: AppSizes.f10,
                      color: context.grey89,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
          AppSizes.h4,
          RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: metric.change,
                  style: TextStyle(
                    fontSize: AppSizes.f10,
                    fontWeight: FontWeight.w800,
                    color: metric.negative
                        ? context.primaryRedColor
                        : AppColorsConstants.green,
                  ),
                ),
                TextSpan(
                  text: '\t\t${metric.subtitle}',
                  style: TextStyle(
                    fontSize: AppSizes.f10,
                    color: context.grey89,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

