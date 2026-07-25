import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_images.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_network_image.dart';
import 'package:yuri_sale/core/widgets/common_outline_button.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/product/data/model/product_model.dart';
import 'package:yuri_sale/features/product/domain/entities/add_cart_data.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_bloc.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_event.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_state.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: AppColorsConstants.greyC8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Product Image
            Center(
              child: CommonNetworkImage(
                height: AppSizes.image80,
                width: AppSizes.image80,
                imageUrl: product.image,
              ),
            ),
            AppSizes.h10,

            // Product Name
            CommonTextWidget(
              overFlow: TextOverflow.ellipsis,
              title: product.name,
              color: AppColorsConstants.black,
              fontWeight: FontWeight.w700,
              fontSize: AppSizes.f14,
            ),
            AppSizes.h4,
            // Price
            CommonTextWidget(
              title: product.list_price.toString(),
              color: AppColorsConstants.primaryRedColor,
              fontWeight: FontWeight.w500,
              fontSize: AppSizes.f14,
            ),

            // Stock & Warehouse
            if (product.warehouse_stock.isNotEmpty) ...[
              AppSizes.h4,
              CommonTextWidget(
                title: product.warehouse_stock.first.available_stock.toString(),
                color: AppColorsConstants.grey89,
                fontWeight: FontWeight.w500,
                fontSize: AppSizes.f12,
              ),
            ],
            if (product.warehouse_stock.isNotEmpty) ...[
              AppSizes.h4,
              Row(
                children: [
                  CommonIconWidget(
                    icon: Icons.location_on_outlined,
                    size: AppSizes.icon14,
                  ),
                  AppSizes.w4,
                  CommonTextWidget(
                    title: product.warehouse_stock.first.warehouse_name,
                    color: AppColorsConstants.black,
                    fontWeight: FontWeight.w400,
                    fontSize: AppSizes.f12,
                  ),
                ],
              ),
            ],
            AppSizes.h10,
            // Add to Cart Button
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return CommonOutlineButton(
                  isLoading: state.loadingProductId == product.id,
                  onTap: product.already_in_cart
                      ? () => AppRoutes.pushNamed(RouteNames.cartPage)
                      : () {
                          context.read<ProductBloc>().add(
                            AddCartEvent(
                              AddCartData(productId: product.id.toInt()),
                            ),
                          );
                        },
                  borderRadius: AppSizes.r8,
                  imagePath: product.already_in_cart
                      ? null
                      : AppImagesConstants.plusCircleIcon,
                  title: product.already_in_cart
                      ? AppStringsConstants.goToCart
                      : AppStringsConstants.addToCart,
                  height: AppSizes.hS35,
                  fontWeight: FontWeight.w600,
                  borderColor: AppColorsConstants.primaryRedColor,
                  textColor: AppColorsConstants.primaryRedColor,
                );
              },
            ),
            AppSizes.h10,
          ],
        ),
      ),
    );
  }
}
