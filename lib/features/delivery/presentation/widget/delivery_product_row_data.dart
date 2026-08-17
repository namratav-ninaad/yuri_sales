import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/delivery/data/model/delivery.dart';

class DeliveryProductRowData extends StatelessWidget {
  const DeliveryProductRowData({
    super.key,
    required this.deliveryProduct,
  });

  final DeliveryProductModel deliveryProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.p12),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: CommonTextWidget(
              textAlign: TextAlign.center,
              title: deliveryProduct.productName,
              fontSize: AppSizes.f14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 3,
            child: CommonTextWidget(
              title: deliveryProduct.orderedQty.toInt().toString(),
              fontSize: AppSizes.f12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 2,
            child: CommonTextWidget(
              title: deliveryProduct.deliveredQty.toInt().toString(),
              fontSize: AppSizes.f12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 3,
            child: CommonTextWidget(
              title: deliveryProduct.uom,
              fontSize: AppSizes.f12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
