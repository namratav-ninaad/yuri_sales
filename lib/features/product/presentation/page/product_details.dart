import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_back_button.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_network_image.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_event.dart';
import 'package:yuri_sale/features/product/data/model/product.dart';
import 'package:yuri_sale/features/product/domain/entities/add_cart_data.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_bloc.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_event.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_state.dart';
import 'package:yuri_sale/features/product/presentation/widget/product_two_text.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  String getAttribute(String key) {
    try {
      return product.attributes
          .firstWhere((e) => e.attributeName == key)
          .values
          .first
          .name;
    } catch (_) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.white,
        appBar: CommonAppbarWidget(
          title: product.internalReference,
          leading: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return CommonBackButton(
                onTap: () {
                  AppRoutes.pop(true);
                  context.read<CartBloc>().add(FetchCart());
                  context.read<ProductBloc>().add(
                    FetchProductsEvent(
                      query: '',
                      categoryId: state.selectedCategory?.id ?? 0,
                    ),
                  );
                },
              );
            },
          ),
        ),

        bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(AppSizes.p12),
              child: CommonButton(
                isLoading: state.loadingProductId == product.id,
                onTap: product.alreadyInCart
                    ? () => AppRoutes.pushNamed(RouteNames.cartPage)
                    : () {
                        context.read<ProductBloc>().add(
                          AddCartEvent(
                            AddCartData(productId: product.id.toInt()),
                          ),
                        );
                      },
                title: product.alreadyInCart
                    ? AppStringsConstants.goToCart
                    : AppStringsConstants.addToCart,
              ),
            );
          },
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CommonNetworkImage(
                  imageUrl: product.image,
                  height: AppSizes.image150,
                ),
              ),

              AppSizes.h20,
              CommonTextWidget(
                title: product.name,
                fontSize: AppSizes.f16,
                fontWeight: FontWeight.w700,
              ),
              AppSizes.h12,
              Row(
                children: [
                  Expanded(
                    child: CommonTextWidget(
                      title:
                          '${product.currencySymbol} ${product.listPrice.toStringAsFixed(2)}',
                      fontSize: AppSizes.f16,
                      fontWeight: FontWeight.w700,
                      color: context.primaryRedColor,
                    ),
                  ),
                  Expanded(
                    child: CommonTextWidget(
                      title:
                          '${AppStringsConstants.stock}\t${AppStringsConstants.colon}\t${product.totalStock.onHand.toInt()}',
                      fontSize: AppSizes.f14,
                      fontWeight: FontWeight.w600,
                      color: AppColorsConstants.green,
                    ),
                  ),
                ],
              ),
              AppSizes.h12,

              ProductTwoText(
                title: AppStringsConstants.brand,
                value: getAttribute(AppStringsConstants.brand),
              ),
              ProductTwoText(
                title: AppStringsConstants.sku,
                value: product.internalReference,
              ),
              ProductTwoText(
                title: AppStringsConstants.diameter,
                value: getAttribute(AppStringsConstants.diameter),
              ),
              ProductTwoText(
                title: AppStringsConstants.thickness,
                value: getAttribute(AppStringsConstants.thickness),
              ),
              ProductTwoText(
                title: AppStringsConstants.bore,
                value: getAttribute(AppStringsConstants.bore),
              ),
              if (product.warehouseStock.isNotEmpty) ...[
                AppSizes.h12,
                CommonTextWidget(
                  title: AppStringsConstants.warehouseStock,
                  fontSize: AppSizes.f16,
                  fontWeight: FontWeight.w700,
                ),
                AppSizes.h10,

                ListView.separated(
                  separatorBuilder: (context, index) => AppSizes.h10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: product.warehouseStock.length,
                  itemBuilder: (context, index) {
                    final warehouse = product.warehouseStock[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: context.greyFA,
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                        // border: Border.all(color: context.greyC8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.p12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductTwoText(
                              title: AppStringsConstants.warehouse,
                              value: warehouse.warehouseName,
                            ),

                            ProductTwoText(
                              title: AppStringsConstants.company,
                              value: warehouse.companyName,
                            ),

                            ProductTwoText(
                              title: AppStringsConstants.stock,
                              value: warehouse.availableStock
                                  .toInt()
                                  .toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
