import 'package:flutter/material.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';

class CommonCircularProgressIndicator extends StatelessWidget {
  const CommonCircularProgressIndicator({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? context.primaryRedColor,
    );
  }
}
