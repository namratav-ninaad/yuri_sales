import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final String? errorText;
  final bool enabled;
  final Color? fillColor;
  final bool filled;
  final Color? textColor;
  final Color? borderColor;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.prefixIcon,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
    this.onChanged,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled = true,
    this.onTap,
    this.suffixIcon,
    this.errorText,
    this.fillColor,
    this.filled = false,
    this.textColor,
    this.borderColor,
    this.maxLength,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines,
      readOnly: readOnly,
      enabled: enabled,
      maxLength: maxLength,
      cursorColor: AppColorsConstants.primaryRedColor,
      style: TextStyle(
        fontSize: AppSizes.f14,
        fontWeight: FontWeight.w400,
        color: textColor ?? AppColorsConstants.black,
      ),
      inputFormatters: inputFormatters,
      onTap: onTap,
      decoration: InputDecoration(
        counterText: '',
        fillColor: fillColor,
        filled: filled,
        errorText: errorText,
        labelText: labelText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p16,
          vertical: AppSizes.p12,
        ),
        labelStyle: TextStyle(
          color: textColor ?? AppColorsConstants.black,
          fontSize: AppSizes.f14,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon != null
            ? CommonIconWidget(
                icon: prefixIcon!,
                color: textColor ?? AppColorsConstants.black,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(
            color: borderColor ?? AppColorsConstants.greyC8,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(
            color: borderColor ?? AppColorsConstants.greyC8,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(
            color: borderColor ?? AppColorsConstants.greyC8,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(
            color: borderColor ?? AppColorsConstants.greyC8,
          ),
        ),
      ),
    );
  }
}
