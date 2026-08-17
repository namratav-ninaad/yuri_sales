import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart';
import 'package:yuri_sale/features/customer/presentation/widget/customer_card.dart';
import 'package:yuri_sale/features/customer/presentation/widget/customer_tile.dart';
import 'package:yuri_sale/features/invoice/domain/entities/invoice_data.dart';
import 'package:yuri_sale/features/order/domain/entities/order_data.dart';
import 'package:yuri_sale/features/send_message/domain/entities/send_message_data.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key, required this.customer});

  final CustomerModel customer;

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: context.white,
          appBar: CommonAppbarWidget(title: AppStringsConstants.customerDetail),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.p24),
            child: Column(
              children: [
                CustomerCard(
                  customer: widget.customer,
                  companyName: widget.customer.companyName.isNotEmpty
                      ? widget.customer.companyName
                      : null,
                  contentPadding: EdgeInsets.zero,
                  boxShadow: [],
                  color: AppColorsConstants.transparent,
                ),
                AppSizes.h32,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                  onTap: () => AppRoutes.pushNamed(
                    RouteNames.orderPage,
                    arguments: OrderData(
                      backButtonShow: true,
                      status: OrderStatus.draft,
                      partnerId: widget.customer.contactId.toInt(),
                    ),
                  ),
                  title: AppStringsConstants.quotations,
                  icon: Icons.shopping_cart_outlined,
                  value: widget.customer.quotationsCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                  onTap: () => AppRoutes.pushNamed(
                    RouteNames.orderPage,
                    arguments: OrderData(
                      backButtonShow: true,
                      status: OrderStatus.sale,
                      partnerId: widget.customer.contactId.toInt(),
                    ),
                  ),
                  title: AppStringsConstants.salesOrder,
                  icon: Icons.currency_exchange_rounded,
                  value: widget.customer.salesCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                  onTap: () => AppRoutes.pushNamed(
                    RouteNames.invoicePage,
                    arguments: InvoiceData(
                      partnerId: widget.customer.contactId.toInt(),
                    ),
                  ),
                  title: AppStringsConstants.invoices,
                  icon: Icons.edit_note,
                  value:
                      '${widget.customer.currencySymbol} ${widget.customer.totalInvoice}',
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                  onTap: () => AppRoutes.pushNamed(
                    RouteNames.invoicePage,
                    arguments: InvoiceData(
                      partnerId: widget.customer.contactId.toInt(),
                      isCustomer: true,
                    ),
                  ),
                  title: AppStringsConstants.customerStatement,
                  icon: Icons.payment_outlined,
                  value:
                      '${widget.customer.currencySymbol} ${widget.customer.customerStatement}',
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                  onTap: () => AppRoutes.pushNamed(
                    RouteNames.deliveryPage,
                    arguments: widget.customer.contactId.toInt(),
                  ),
                  title: AppStringsConstants.deliveryHistory,
                  icon: Icons.local_shipping_outlined,
                  value: widget.customer.deliveryCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                  onTap: () => AppRoutes.pushNamed(
                    RouteNames.sendMessagePage,
                    arguments: SendMessageData(
                      name: widget.customer.fullName,
                      partnerId: widget.customer.contactId.toInt(),
                      email: widget.customer.email,
                    ),
                  ),
                  title: AppStringsConstants.sendMessage,
                  icon: Icons.email_outlined,
                  value: widget.customer.emailCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                  onTap: () => AppRoutes.pushNamed(
                    RouteNames.logNotePage,
                    arguments: widget.customer.contactId.toInt(),
                  ),
                  title: AppStringsConstants.logNote,
                  icon: Icons.edit_note,
                  value: widget.customer.commentCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                  onTap: () => AppRoutes.pushNamed(
                    RouteNames.activityPage,
                    arguments: widget.customer.contactId.toInt(),
                  ),
                  title: AppStringsConstants.activities,
                  icon: Icons.calendar_month,
                  value: widget.customer.activityCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
