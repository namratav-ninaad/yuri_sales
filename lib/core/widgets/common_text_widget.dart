import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';

class CommonTextWidget extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overFlow;
  final TextAlign? textAlign;

  const CommonTextWidget({
    super.key,
    this.title = 'eCommerce',
    this.fontSize,
    this.fontWeight,
    this.color,
    this.overFlow,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
        overflow: overFlow,
        fontSize: fontSize ?? AppSizes.f28,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color ?? AppColorsConstants.white,
      ),
    );
  }
}
