import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_network_image.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/cart/data/model/cart.dart';

class CartCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final VoidCallback? onRemove;

  const CartCard({
    super.key,
    required this.item,
    this.onIncrease,
    this.onDecrease,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        CommonNetworkImage(
          height: AppSizes.image80,
          width: AppSizes.image80,
          imageUrl: item.product_image,
        ),

        AppSizes.w12,
        // Name + Price + Quantity
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                title: item.product_name,
                fontSize: AppSizes.f14,
                fontWeight: FontWeight.w600,
                color: AppColorsConstants.black,
              ),
              AppSizes.h4,
              CommonTextWidget(
                title: item.price.toString(),
                fontSize: AppSizes.f14,
                fontWeight: FontWeight.w600,
                color: AppColorsConstants.primaryRedColor,
              ),
              AppSizes.h4,
              // Quantity and Remove controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSizes.p4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                      border: Border.all(color: AppColorsConstants.greyC8),
                    ),
                    child: Row(
                      children: [
                        CommonIconWidget(
                          icon: Icons.remove,
                          onTap: onDecrease,
                          color: item.qty <= 1
                              ? AppColorsConstants.greyC8
                              : AppColorsConstants.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.p12,
                          ),
                          child: CommonTextWidget(
                            title: item.qty.toString(),
                            fontSize: AppSizes.f14,
                            fontWeight: FontWeight.w600,
                            color: AppColorsConstants.black,
                          ),
                        ),
                        CommonIconWidget(icon: Icons.add, onTap: onIncrease),
                      ],
                    ),
                  ),
                  CommonIconWidget(
                    onTap: onRemove,
                    icon: Icons.delete_outline,
                    color: AppColorsConstants.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
