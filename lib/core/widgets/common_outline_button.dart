import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_assets_image_widget.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class CommonOutlineButton extends StatelessWidget {
  const CommonOutlineButton({
    super.key,
    required this.title,
    this.imagePath,
    this.height,
    this.borderRadius,
    this.borderColor,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.padding,
    this.onTap,
    this.isLoading = false,
  });

  final String title;
  final String? imagePath;
  final double? height;
  final double? borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height ?? AppSizes.hS45,
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? AppColorsConstants.greyC8),
          borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.r12),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CommonCircularProgressIndicator(),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imagePath != null) ...[
                    CommonAssetsImageWidget(
                      imagePath: imagePath!,
                      imageHeight: AppSizes.icon20,
                      imageWidth: AppSizes.icon20,
                    ),
                    AppSizes.w12,
                  ],
                  CommonTextWidget(
                    title: title,
                    color: textColor ?? AppColorsConstants.black,
                    fontSize: fontSize ?? AppSizes.f16,
                    fontWeight: fontWeight ?? FontWeight.w400,
                  ),
                ],
              ),
      ),
    );
  }
}
