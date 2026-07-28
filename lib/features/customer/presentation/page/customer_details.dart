import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart';
import 'package:yuri_sale/features/customer/presentation/widget/customer_card.dart';
import 'package:yuri_sale/features/customer/presentation/widget/customer_tile.dart';
import 'package:yuri_sale/features/order/domain/entities/order_data.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key, required this.customer});

  final CustomerModel customer;

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              color: AppColorsConstants.transparent,
            ),
            AppSizes.h32,
            CommonDivider(),
            AppSizes.h12,
            CustomerTile(
              onTap: () => AppRoutes.pushNamed(
                RouteNames.orderPage,
                arguments: OrderData(backButtonShow: true, status: 'draft'),
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
                arguments: OrderData(backButtonShow: true, status: 'sale'),
              ),
              title: AppStringsConstants.salesOrder,
              icon: Icons.currency_exchange_rounded,
              value: widget.customer.invoiceCount.toString(),
            ),
            AppSizes.h12,
            CommonDivider(),
            AppSizes.h12,
            CustomerTile(
              title: AppStringsConstants.invoices,
              icon: Icons.edit_note,
              value: 'AED 20.00',
            ),
            AppSizes.h12,
            CommonDivider(),
            AppSizes.h12,
            CustomerTile(
              title: AppStringsConstants.customerStatement,
              icon: Icons.payment_outlined,
              value: 'AED 20.00',
            ),
            AppSizes.h12,
            CommonDivider(),
            AppSizes.h12,
            CustomerTile(
              title: AppStringsConstants.deliveryHistory,
              icon: Icons.local_shipping_outlined,
              value: widget.customer.deliveryCount.toString(),
            ),
            AppSizes.h12,
            CommonDivider(),
            AppSizes.h12,
            CustomerTile(
              title: AppStringsConstants.notes,
              icon: Icons.edit_note,
              value: widget.customer.notes.isNotEmpty ? '1' : '0',
            ),
            AppSizes.h12,
            // CommonDivider(),
           /* AppSizes.h12,
            CustomerTile(
              title: AppStringsConstants.activities,
              icon: Icons.calendar_month,
              value: widget.customer.activityCount.toString(),
            ),
            AppSizes.h12,
            CommonDivider(),*/
          ],
        ),
      ),
    );
  }
}
