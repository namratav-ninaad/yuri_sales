import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/invoice/domain/entities/invoice_detail_data.dart';
import 'package:yuri_sale/features/invoice/presentation/widget/invoice_status.dart';
import 'package:yuri_sale/features/invoice/presentation/widget/invoice_product_item.dart';
import 'package:yuri_sale/features/order/presentation/widget/customer_card.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_summary.dart';
import 'package:yuri_sale/features/order/presentation/widget/payment_method.dart';

class InvoiceDetail extends StatelessWidget {
  const InvoiceDetail({super.key, required this.data});

  final InvoiceDetailData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(title: data.invoiceModel.invoiceNumber),
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
                    companyName: data.invoiceModel.company.name,
                    fullName: data.invoiceModel.customer.name,
                    orderStatus: InvoiceStatusChip(
                      status: data.invoiceModel.state,
                    ),
                    orderDate: data.invoiceModel.invoiceDate,
                    priceList: '',
                    salesPerson: '',
                  ),

                  AppSizes.h24,
                  InvoiceProductItem(
                    title: data.isCustomer
                        ? AppStringsConstants.customerStatementItems
                        : AppStringsConstants.invoiceItems,
                    invoiceLine: data.invoiceModel.lines,
                    currency: data.invoiceModel.currency,
                  ),
                  AppSizes.h12,
                  OrderSummary(
                    title: data.isCustomer
                        ? AppStringsConstants.customerStatementSummary
                        : AppStringsConstants.invoiceSummary,
                    currency: data.invoiceModel.currency,
                    total: data.invoiceModel.totalAmount,
                    untaxedAmount: data.invoiceModel.untaxedAmount,
                    vat: data.invoiceModel.taxAmount,
                  ),
                  AppSizes.h24,
                  if (data.invoiceModel.paymentState.isNotEmpty) ...[
                    PaymentMethod(
                      paymentMethod: data.invoiceModel.paymentState,
                    ),
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
