import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_network_image.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart';
import 'package:yuri_sale/features/customer/presentation/widget/tag_widget.dart';

class CustomerCard extends StatelessWidget {
  final CustomerModel customer;
  final String? companyName;
  final EdgeInsetsGeometry? contentPadding;
  final Color? color;
  final Function()? onTap;
  final double? radius;
  final double? horizontalTitleGap;
  final List<BoxShadow>? boxShadow;

  const CustomerCard({
    super.key,
    required this.customer,
    this.companyName,
    this.contentPadding,
    this.color,
    this.onTap,
    this.radius,
    this.horizontalTitleGap,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppSizes.r12);

    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color ?? context.greyFA,

          boxShadow:
              boxShadow ??
              [
                BoxShadow(
                  color: context.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
        ),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          splashColor: AppColorsConstants.transparent,
          highlightColor: AppColorsConstants.transparent,
          child: ListTile(
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: AppSizes.p12,
                  vertical: AppSizes.p8,
                ),

            leading: CircleAvatar(
              radius: radius ?? AppSizes.icon24,
              backgroundColor: context.greyC8.withValues(alpha: 0.2),
              child: CommonNetworkImage(imageUrl: customer.image),
            ),

            horizontalTitleGap: horizontalTitleGap,

            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (companyName != null)
                        CommonTextWidget(
                          title: companyName!,
                          color: context.black,
                          fontWeight: FontWeight.w700,
                          fontSize: AppSizes.f14,
                        ),

                      CommonTextWidget(
                        title: customer.fullName,
                        color: context.black,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSizes.f12,
                      ),
                    ],
                  ),
                ),

                if (customer.tagNames.isNotEmpty)
                  Flexible(child: TagWidget(title: customer.tagNames.first)),
              ],
            ),

            subtitle: customer.phone.isNotEmpty || customer.email.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (customer.phone.isNotEmpty)
                        CommonTextWidget(
                          title: customer.phone,
                          color: context.grey89,
                          fontWeight: FontWeight.w500,
                          fontSize: AppSizes.f12,
                        ),

                      if (customer.email.isNotEmpty)
                        CommonTextWidget(
                          title: customer.email,
                          color: context.grey89,
                          fontWeight: FontWeight.w500,
                          fontSize: AppSizes.f12,
                        ),
                    ],
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
