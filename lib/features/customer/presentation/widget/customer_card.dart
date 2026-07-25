import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_network_image.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart';
import 'package:yuri_sale/features/customer/presentation/widget/tag_widget.dart';

class CustomerCard extends StatelessWidget {
  final CustomerModel customer;
  final String? branchName;
  final EdgeInsetsGeometry? contentPadding;
  final Color? color;
  final Function()? onTap;

  const CustomerCard({
    super.key,
    required this.customer,
    this.branchName,
    this.contentPadding,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: color ?? AppColorsConstants.greyC8),
      ),
      child: ListTile(
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(
              horizontal: AppSizes.p12,
              vertical: AppSizes.p8,
            ),
        leading: CircleAvatar(
          radius: AppSizes.icon24,
          backgroundColor: AppColorsConstants.greyC8.withValues(alpha: 0.2),
          child: CommonNetworkImage(imageUrl: customer.image),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (branchName != null)
                    CommonTextWidget(
                      title: branchName!,
                      color: AppColorsConstants.black,
                      fontWeight: FontWeight.w700,
                      fontSize: AppSizes.f14,
                    ),
                  CommonTextWidget(
                    title: customer.full_name,
                    color: AppColorsConstants.black,
                    fontWeight: FontWeight.w500,
                    fontSize: AppSizes.f12,
                  ),
                ],
              ),
            ),
            if (customer.tag_names.isNotEmpty) TagWidget(title: customer.tag_names.first),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget(
              title: customer.phone,
              color: AppColorsConstants.grey89,
              fontWeight: FontWeight.w500,
              fontSize: AppSizes.f12,
            ),
            CommonTextWidget(
              title: customer.email,
              color: AppColorsConstants.grey89,
              fontWeight: FontWeight.w500,
              fontSize: AppSizes.f12,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
