import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/delivery/data/model/delivery.dart';
import 'package:yuri_sale/features/delivery/presentation/widget/delivery_status_chip.dart';

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({super.key, required this.delivery, this.onTap});

  final DeliveryModel delivery;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: context.greyC8),
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
                      title: delivery.deliveryName,
                      fontSize: AppSizes.f16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  DeliveryStatusChip(status: delivery.state),
                ],
              ),

              AppSizes.h8,

              /// Customer
              Row(
                children: [
                  Expanded(
                    child: CommonTextWidget(
                      title: delivery.partnerName,
                      fontSize: AppSizes.f14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: CommonTextWidget(
                      title: delivery.destinationLocation,
                      textAlign: TextAlign.right,
                      fontSize: AppSizes.f14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              AppSizes.h8,
            ],
          ),
        ),
      ),
    );
  }
}
