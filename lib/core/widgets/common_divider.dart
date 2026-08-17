import 'package:flutter/material.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';

class CommonDivider extends StatelessWidget {
  const CommonDivider({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(color: color ?? context.greyC8, height: 1, thickness: 1);
  }
}
