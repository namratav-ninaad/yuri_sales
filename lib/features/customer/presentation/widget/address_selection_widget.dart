import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class AddressSelectionWidget extends StatelessWidget {
  const AddressSelectionWidget({
    super.key,
    required this.onChanged,
    required this.groupValue,
  });

  final ValueChanged<AddressType?> onChanged;
  final AddressType groupValue;

  @override
  Widget build(BuildContext context) {
    final List<AddressType> addressList = [
      AddressType.gpsLocation,
      AddressType.shippingAddress,
      AddressType.billingAddress,
    ];

    return RadioGroup<AddressType>(
      groupValue: groupValue,
      onChanged: onChanged,
      child: Wrap(
        spacing: AppSizes.p4,
        children: addressList.map((item) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<AddressType>(
                value: item,
                activeColor: context.primaryRedColor,
              ),
              CommonTextWidget(
                title: item.label,
                fontSize: AppSizes.f14,
                color: context.black,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}