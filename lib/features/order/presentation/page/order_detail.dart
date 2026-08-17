import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';
import 'package:yuri_sale/features/order/presentation/widget/customer_card.dart';
import 'package:yuri_sale/features/order/presentation/widget/delivery_details.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_item.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_status_chip.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_summary.dart';
import 'package:yuri_sale/features/order/presentation/widget/payment_method.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: context.white,
          appBar: CommonAppbarWidget(title: orderModel.orderNumber),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSizes.p24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        title: AppStringsConstants.customerDetail,
                        color: context.black,
                        fontWeight: FontWeight.w700,
                        fontSize: AppSizes.f16,
                      ),
                      AppSizes.h12,
                      CustomerCard(
                        companyName: orderModel.company,
                        fullName: orderModel.customer.name,
                        orderStatus: OrderStatusChip(status: orderModel.status),
                        orderDate: orderModel.orderDate,
                        priceList: orderModel.priceList,
                        salesPerson: orderModel.salesperson,
                      ),

                      AppSizes.h24,
                      OrderItems(
                        orderLines: orderModel.orderLines,
                        currency: orderModel.currency,
                      ),
                      AppSizes.h12,
                      OrderSummary(
                        title: AppStringsConstants.orderSummary,
                        currency: orderModel.currency,
                        total: orderModel.totalAmount,
                        untaxedAmount: orderModel.untaxedAmount,
                        vat: orderModel.taxAmount,
                      ),
                      AppSizes.h24,
                      AddressDetails(addressModel: orderModel.deliveryAddress),
                      AppSizes.h24,
                      AddressDetails(
                        addressModel: orderModel.invoiceAddress,
                        title: AppStringsConstants.invoiceDetail,
                        icon: Icons.receipt_long_outlined,
                      ),
                      AppSizes.h24,
                      if (orderModel.paymentTerm.isNotEmpty) ...[
                        PaymentMethod(paymentMethod: orderModel.paymentTerm),
                        AppSizes.h24,
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
