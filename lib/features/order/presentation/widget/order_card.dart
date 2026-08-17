import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/core/widgets/date_helper.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_status_chip.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, this.onTap});

  final OrderModel order;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.r12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.p12),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Order Number & Status
            Row(
              children: [
                Expanded(
                  child: CommonTextWidget(
                    title: order.orderNumber,
                    fontSize: AppSizes.f16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                OrderStatusChip(status: order.status),
              ],
            ),

            AppSizes.h8,

            /// Customer
            Row(
              children: [
                Expanded(
                  child: CommonTextWidget(
                    title: order.customer.name,
                    fontSize: AppSizes.f14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: CommonTextWidget(
                    title: order.company,
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
                  title: '${order.currency} ${order.totalAmount}',
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

            /// Date & Salesperson (one row)
            Row(
              children: [
                // Date
                Expanded(
                  child: Row(
                    children: [
                      const CommonIconWidget(
                        icon: Icons.calendar_today_outlined,
                        size: AppSizes.icon16,
                      ),
                      AppSizes.w8,
                      Flexible(
                        child: CommonTextWidget(
                          title: DateHelper.dMy(order.orderDate),
                          fontSize: AppSizes.f14,
                          color: context.grey89,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSizes.w8,
                // Salesperson
                if (order.salesperson.isNotEmpty)
                  Expanded(
                    child: Row(
                      children: [
                        const CommonIconWidget(
                          icon: Icons.person_outline,
                          size: AppSizes.icon20,
                        ),
                        AppSizes.w8,
                        Flexible(
                          child: CommonTextWidget(
                            title: order.salesperson,
                            fontSize: AppSizes.f14,
                            color: context.grey89,
                            overFlow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
