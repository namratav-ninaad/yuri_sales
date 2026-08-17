import 'package:flutter/material.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';

class CommonCircularProgressIndicator extends StatelessWidget {
  const CommonCircularProgressIndicator({
    super.key,
    this.color,
    this.strokeWidth,
  });

  final Color? color;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: strokeWidth,
      color: color ?? context.primaryRedColor,
    );
  }
}
