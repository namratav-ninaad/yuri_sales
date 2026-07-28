import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class CommonDropdown<T> extends StatelessWidget {
  final String hintText;
  final T? initialValue;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final String? Function(T?)? validator;

  const CommonDropdown({
    super.key,
    required this.hintText,
    this.initialValue,
    required this.items,
    required this.itemLabel,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      initialValue: initialValue,
      borderRadius: BorderRadius.circular(AppSizes.p12),
      hint: CommonTextWidget(
        title: hintText,
        fontSize: AppSizes.f14,
        fontWeight: FontWeight.w400,
        color: enabled ? context.grey89 : context.grey89.withValues(alpha: 0.5),
      ),
      decoration: InputDecoration(
        enabled: enabled,
        filled: true,
        fillColor: enabled ? context.white : context.greyF2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.p12),
          borderSide: BorderSide(
            color: enabled ? context.greyC8 : context.greyF2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(
            color: enabled ? context.greyC8 : context.greyF2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(
            color: enabled ? context.greyC8 : context.greyF2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(
            color: enabled ? context.greyC8 : context.greyF2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p16,
          vertical: AppSizes.p12,
        ),
      ),
      validator: validator,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: CommonTextWidget(
            title: itemLabel(item),
            fontSize: AppSizes.f14,
            fontWeight: FontWeight.w500,
            color: context.black,
            overFlow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
