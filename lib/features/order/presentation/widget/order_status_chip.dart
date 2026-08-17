import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final orderStatus = OrderStatus.fromString(status);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p12,
        vertical: AppSizes.p4,
      ),
      decoration: BoxDecoration(
        color: orderStatus?.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.r8),
      ),
      child: CommonTextWidget(
        title: orderStatus?.label ?? '',
        color: orderStatus?.color,
        fontSize: AppSizes.f10,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
