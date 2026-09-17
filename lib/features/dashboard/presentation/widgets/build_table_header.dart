import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class BuildTableHeader extends StatelessWidget {
  const BuildTableHeader({
    super.key,
    required this.titles,
    this.titleExpanded,
  });

  final List<String> titles;
  final String? titleExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.p8,
        horizontal: AppSizes.p12,
      ),
      decoration: BoxDecoration(
        color: context.greyF2,
      ),
      child: Row(
        children: titles.asMap().entries.map((entry) {
          final index = entry.key;
          final title = entry.value;

          int flex = 2;

          if (index == 0) {
            flex = 1;
          } else if (titleExpanded == title) {
            flex = 4;
          }

          return Expanded(
            flex: flex,
            child: CommonTextWidget(
              title: title,
              fontSize: AppSizes.f12,
              color: context.grey89,
              fontWeight: FontWeight.w600,
            ),
          );
        }).toList(),
      ),
    );
  }
}
