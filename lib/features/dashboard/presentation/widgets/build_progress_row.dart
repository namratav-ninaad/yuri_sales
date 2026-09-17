import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class BuildProgressRow extends StatelessWidget {
  final String title;
  final num amount;
  final num percentage;
  final String currencyName;

  const BuildProgressRow({
    super.key,
    required this.title,
    required this.amount,
    required this.percentage,
    required this.currencyName,
  });

  @override
  Widget build(BuildContext context) {
    final progress = percentage.toDouble().clamp(0.0, 100.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CommonTextWidget(
                  title: title,
                  fontSize: AppSizes.f12,
                  fontWeight: FontWeight.w700,
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(width: AppSizes.p8),

              CommonTextWidget(
                title:
                    '$currencyName $amount '
                    '(${percentage.toStringAsFixed(2)}%)',
                fontSize: AppSizes.f10,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),

          AppSizes.h8,

          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r4),
            child: LinearProgressIndicator(
              value: progress / 100,
              minHeight: 8,
              backgroundColor: context.greyF2,
              valueColor: AlwaysStoppedAnimation<Color>(
                context.primaryRedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
