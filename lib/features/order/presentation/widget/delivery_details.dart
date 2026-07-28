import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_bg_icon_and_text.dart';
import 'package:yuri_sale/features/cart/presentation/widget/summary_row.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({
    super.key,
    required this.addressModel,
    this.title,
    this.icon,
  });

  final AddressModel addressModel;
  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        color: context.white,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: context.greyC8),
      ),
      child: Column(
        children: [
          CommonBgIconAndText(
            icon: icon ?? Icons.local_shipping_outlined,
            title: title ?? AppStringsConstants.deliveryDetail,
          ),
          AppSizes.h12,
          SummaryRow(
            textColor: context.grey89,
            valueColor: context.black,
            label: AppStringsConstants.deliveryDate,
            value: addressModel.name,
          ),
          if (addressModel.fullAddress.isNotEmpty)
            SummaryRow(
              textColor: context.grey89,
              valueColor: context.black,
              label: AppStringsConstants.deliveryAddress,
              value: addressModel.fullAddress,
            ),
        ],
      ),
    );
  }
}
