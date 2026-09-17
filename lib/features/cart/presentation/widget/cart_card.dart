import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_network_image.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/cart/data/model/cart.dart';
import 'package:yuri_sale/features/product/presentation/widget/common_quantity_selector.dart';

class CartCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final VoidCallback? onRemove;
  final String currentCode;
  final ValueChanged<int>? onQuantityChanged;

  /// Maximum quantity allowed
  final int maxQuantity;

  const CartCard({
    super.key,
    required this.item,
    this.onIncrease,
    this.onDecrease,
    this.onRemove,
    this.onQuantityChanged,
    required this.maxQuantity,
    required this.currentCode,
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
          imageUrl: item.productImage,
        ),

        AppSizes.w12,
        // Name + Price + Quantity
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                title: item.productName,
                fontSize: AppSizes.f14,
                fontWeight: FontWeight.w600,
                color: context.black,
              ),
              AppSizes.h4,
              CommonTextWidget(
                title: '$currentCode ${item.price.toString()}',
                fontSize: AppSizes.f14,
                fontWeight: FontWeight.w600,
                color: context.primaryRedColor,
              ),
              AppSizes.h4,
              // Quantity and Remove controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: AppSizes.s100,
                    child: CommonQuantitySelector(
                      onDecrease: onDecrease,
                      onIncrease: onIncrease,
                      quantity: item.qty.toInt(),
                      minQuantity: 0,
                      maxQuantity: maxQuantity,
                      onQuantityChanged: onQuantityChanged,
                    ),
                  ),
                  AppSizes.w24,
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
