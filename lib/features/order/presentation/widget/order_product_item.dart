import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({
    super.key,
    required this.orderLine,
    required this.currency,
  });

  final OrderLineModel orderLine;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.p12),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: CommonTextWidget(
              title: orderLine.productName,
              fontSize: AppSizes.f14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 3,
            child: CommonTextWidget(
              title: '$currency ${orderLine.unitPrice}',
              fontSize: AppSizes.f12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 2,
            child: CommonTextWidget(
              title: orderLine.quantity.toInt().toString(),
              fontSize: AppSizes.f12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 3,
            child: CommonTextWidget(
              title: '${orderLine.discount}',
              fontSize: AppSizes.f12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 3,
            child: CommonTextWidget(
              title: '$currency ${orderLine.subtotal}',
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
