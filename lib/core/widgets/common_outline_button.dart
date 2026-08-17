import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
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
    this.imageHeight,
    this.imageWidth,
    this.sizedBoxWidth,
    this.circularSize,
    this.strokeWidth,
  });

  final String title;
  final String? imagePath;
  final double? height;
  final double? borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? imageHeight;
  final double? imageWidth;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  final bool isLoading;
  final Widget? sizedBoxWidth;
  final double? circularSize;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height ?? AppSizes.s45,
        padding: padding,
        decoration: BoxDecoration(
          // border: Border.all(color: borderColor ?? context.greyC8),
          color: context.greyC8.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.r12),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: circularSize ?? AppSizes.s20,
                height: circularSize ?? AppSizes.s20,
                child: CommonCircularProgressIndicator(
                  strokeWidth: strokeWidth,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imagePath != null) ...[
                    CommonAssetsImageWidget(
                      imagePath: imagePath!,
                      imageHeight: imageHeight ?? AppSizes.icon20,
                      imageWidth: imageWidth ?? AppSizes.icon20,
                    ),
                    sizedBoxWidth ?? AppSizes.w12,
                  ],
                  CommonTextWidget(
                    title: title,
                    textAlign: TextAlign.center,
                    overFlow: TextOverflow.ellipsis,
                    color: textColor ?? context.black,
                    fontSize: fontSize ?? AppSizes.f16,
                    fontWeight: fontWeight ?? FontWeight.w400,
                  ),
                ],
              ),
      ),
    );
  }
}
