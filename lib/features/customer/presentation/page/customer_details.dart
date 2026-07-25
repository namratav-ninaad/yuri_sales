import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart';
import 'package:yuri_sale/features/customer/presentation/widget/customer_card.dart';
import 'package:yuri_sale/features/customer/presentation/widget/customer_tile.dart';

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
      backgroundColor: AppColorsConstants.white,
      appBar: CommonAppbarWidget(title: AppStringsConstants.customerDetail),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.p24),
        child: Column(
          children: [
            CustomerCard(
              customer: widget.customer,
              branchName: widget.customer.company_name.isNotEmpty
                  ? widget.customer.company_name
                  : null,
              contentPadding: EdgeInsets.zero,
              color: AppColorsConstants.transparent,
            ),
            AppSizes.h32,
            CommonDivider(),
            AppSizes.h12,
            CustomerTile(
              title: AppStringsConstants.quotations,
              icon: Icons.shopping_cart_outlined,
              value: '8',
            ),
            AppSizes.h12,
            CommonDivider(),
            AppSizes.h12,
            CustomerTile(
              title: AppStringsConstants.invoices,
              icon: Icons.description_outlined,
              value: '15',
            ),
            AppSizes.h12,
            CommonDivider(),
            AppSizes.h12,
            CustomerTile(
              title: AppStringsConstants.payments,
              icon: Icons.payment_outlined,
              value: '10',
            ),
            AppSizes.h12,
            CommonDivider(),
            AppSizes.h12,
            CustomerTile(
              title: AppStringsConstants.deliveryHistory,
              icon: Icons.local_shipping_outlined,
              value: '6',
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
            CommonDivider(),
            AppSizes.h12,
            CustomerTile(
              title: AppStringsConstants.activities,
              icon: Icons.calendar_month,
              value: '14',
            ),
            AppSizes.h12,
            CommonDivider(),
          ],
        ),
      ),
    );
  }
}
