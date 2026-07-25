import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';

class CommonDivider extends StatelessWidget {
  const CommonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: AppColorsConstants.greyC8, height: 1,thickness: 1);
  }
}
