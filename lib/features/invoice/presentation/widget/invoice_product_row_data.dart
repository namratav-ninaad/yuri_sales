import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/invoice/data/model/invoice.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';

class InvoiceProductRowData extends StatelessWidget {
  const InvoiceProductRowData({
    super.key,
    required this.invoiceLine,
    required this.currency,
  });

  final InvoiceLineModel invoiceLine;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.p12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CommonTextWidget(
              title: invoiceLine.productName,
              fontSize: AppSizes.f14,
              fontWeight: FontWeight.w500,
              overFlow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: CommonTextWidget(
              title: '$currency ${invoiceLine.unitPrice}',
              fontSize: AppSizes.f12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              overFlow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: CommonTextWidget(
              title: invoiceLine.quantity.toInt().toString(),
              fontSize: AppSizes.f12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 2,
            child: CommonTextWidget(
              title: '${invoiceLine.discount}',
              fontSize: AppSizes.f12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              overFlow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: CommonTextWidget(
              title: '$currency ${invoiceLine.subtotal}',
              fontSize: AppSizes.f12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              overFlow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
