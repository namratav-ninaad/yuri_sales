import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/core/widgets/date_helper.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({
    super.key,
    required this.companyName,
    required this.fullName,
    required this.priceList,
    required this.salesPerson,
    required this.orderStatus,
    required this.orderDate,
  });

  final String companyName;
  final String fullName;
  final String priceList;
  final String salesPerson;
  final Widget orderStatus;
  final String orderDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        // border: Border.all(color: context.greyC8),
        color: context.greyFA,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CommonTextWidget(
                  title: fullName,
                  color: context.black,
                  fontWeight: FontWeight.w500,
                  fontSize: AppSizes.f12,
                ),
              ),
              AppSizes.w16,
              orderStatus
              // TextChip(color: AppColorsConstants.green, title: orderStatus),
            ],
          ),
          AppSizes.h12,
          Row(
            children: [
              Expanded(
                child: CommonTextWidget(
                  title: companyName,
                  color: context.black,
                  fontWeight: FontWeight.w500,
                  fontSize: AppSizes.f14,
                ),
              ),
              Expanded(
                child: CommonTextWidget(
                  title: DateHelper.dMy(orderDate),
                  fontSize: AppSizes.f10,
                  fontWeight: FontWeight.w400,
                  color: context.grey89,
                ),
              ),
            ],
          ),
          AppSizes.h12,
          Row(
            children: [
              if (salesPerson.isNotEmpty)
                Expanded(
                  child: CommonTextWidget(
                    title: salesPerson,
                    color: context.grey89,
                    fontWeight: FontWeight.w500,
                    fontSize: AppSizes.f12,
                  ),
                ),

              if (priceList.isNotEmpty)
                Expanded(
                  child: CommonTextWidget(
                    title: priceList,
                    color: context.grey89,
                    fontWeight: FontWeight.w500,
                    fontSize: AppSizes.f12,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
