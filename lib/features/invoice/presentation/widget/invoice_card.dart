import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/core/widgets/date_helper.dart';
import 'package:yuri_sale/features/invoice/data/model/invoice.dart';
import 'package:yuri_sale/features/invoice/presentation/widget/invoice_status.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({super.key, required this.invoice, this.onTap});

  final InvoiceModel invoice;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        // border: Border.all(color: context.greyC8),
        color: context.greyFA,
        boxShadow: [
          BoxShadow(
            color: context.black.withValues(alpha: 0.1),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Order Number & Status
              Row(
                children: [
                  Expanded(
                    child: CommonTextWidget(
                      title: invoice.invoiceNumber,
                      fontSize: AppSizes.f16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InvoiceStatusChip(status: invoice.state),
                ],
              ),

              AppSizes.h8,

              /// Customer
              Row(
                children: [
                  Expanded(
                    child: CommonTextWidget(
                      title: invoice.customer.name,
                      fontSize: AppSizes.f14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: CommonTextWidget(
                      title: invoice.company.name,
                      textAlign: TextAlign.right,
                      fontSize: AppSizes.f14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              AppSizes.h8,

              /// Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonTextWidget(
                    title: '${invoice.currency} ${invoice.totalAmount}',
                    fontWeight: FontWeight.w700,
                    fontSize: AppSizes.f14,
                    color: AppColorsConstants.primaryRedColor,
                  ),

                  const CommonIconWidget(
                    icon: Icons.arrow_forward_ios,
                    size: AppSizes.icon16,
                  ),
                ],
              ),
              AppSizes.h8,

              /// Date
              Row(
                children: [
                  const CommonIconWidget(
                    icon: Icons.calendar_today_outlined,
                    size: AppSizes.icon16,
                  ),
                  AppSizes.w8,
                  Flexible(
                    child: CommonTextWidget(
                      title: DateHelper.dMy(invoice.invoiceDate),
                      fontSize: AppSizes.f14,
                      color: context.grey89,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              AppSizes.w8,
            ],
          ),
        ),
      ),
    );
  }
}
