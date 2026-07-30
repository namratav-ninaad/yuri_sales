import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/invoice/data/model/invoice.dart';
import 'package:yuri_sale/features/invoice/presentation/widget/invoice_product_item.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';
import 'package:yuri_sale/features/order/presentation/widget/customer_card.dart';
import 'package:yuri_sale/features/order/presentation/widget/delivery_details.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_item.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_summary.dart';
import 'package:yuri_sale/features/order/presentation/widget/payament_method.dart';

class InvoiceDetail extends StatelessWidget {
  const InvoiceDetail({super.key, required this.invoiceModel});

  final InvoiceModel invoiceModel;

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(title: invoiceModel.invoiceNumber),
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
                    companyName: invoiceModel.company.name,
                    fullName: invoiceModel.customer.name,
                    orderStatus: capitalize(invoiceModel.state),
                    orderDate: invoiceModel.invoiceDate,
                    priceList:'',
                    salesPerson: '',
                  ),

                  AppSizes.h24,
                  InvoiceProductItem(
                    invoiceLine: invoiceModel.lines,
                    currency: invoiceModel.currency,
                  ),
                  AppSizes.h12,
                  OrderSummary(
                    title: AppStringsConstants.invoiceSummary,
                    currency: invoiceModel.currency,
                    total: invoiceModel.totalAmount,
                    untaxedAmount: invoiceModel.untaxedAmount,
                    vat: invoiceModel.taxAmount,
                  ),
                  AppSizes.h24,
                  if (invoiceModel.paymentState.isNotEmpty) ...[
                    PaymentMethod(paymentMethod: invoiceModel.paymentState),
                    AppSizes.h24,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
