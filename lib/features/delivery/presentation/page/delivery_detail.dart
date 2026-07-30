import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/delivery/data/model/delivery.dart';
import 'package:yuri_sale/features/delivery/presentation/widget/delivery_detail_card.dart';
import 'package:yuri_sale/features/delivery/presentation/widget/delivery_product_item.dart';
import 'package:yuri_sale/features/invoice/data/model/invoice.dart';
import 'package:yuri_sale/features/invoice/presentation/widget/invoice_product_item.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';
import 'package:yuri_sale/features/order/presentation/widget/customer_card.dart';
import 'package:yuri_sale/features/order/presentation/widget/delivery_details.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_item.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_summary.dart';
import 'package:yuri_sale/features/order/presentation/widget/payament_method.dart';

class DeliveryDetail extends StatelessWidget {
  const DeliveryDetail({super.key, required this.deliveryModel});

  final DeliveryModel deliveryModel;

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(title: deliveryModel.deliveryName),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.p24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(
                    title: AppStringsConstants.deliveryDetail,
                    color: context.black,
                    fontWeight: FontWeight.w700,
                    fontSize: AppSizes.f16,
                  ),
                  AppSizes.h12,
                  DeliveryDetailCard(
                    destinationLocation: deliveryModel.destinationLocation,
                    sourceLocation: deliveryModel.sourceLocation,
                    fullName: deliveryModel.partnerName,
                    orderStatus: capitalize(deliveryModel.state),
                    orderDate: deliveryModel.doneDate,
                  ),
                  AppSizes.h24,
                  DeliveryProductItem(deliveryProducts: deliveryModel.products),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
