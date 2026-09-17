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
import 'package:yuri_sale/features/product/presentation/widget/common_quantity_selector.dart';
import 'package:yuri_sale/features/product/presentation/widget/product_two_text.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String getAttribute(String key) {
    try {
      return widget.product.attributes
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
    var bloc = context.read<ProductBloc>();
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: context.white,
        appBar: CommonAppbarWidget(
          title: widget.product.internalReference,
          leading: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return CommonBackButton(
                onTap: () {
                  AppRoutes.pop(true);
                  context.read<CartBloc>().add(FetchCart());
                  bloc.add(
                    FetchProductsEvent(
                      query: '',
                      categoryId: state.selectedCategory?.id == 0
                          ? null
                          : state.selectedCategory?.id,
                    ),
                  );
                },
              );
            },
          ),
        ),

        bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
          buildWhen: (previous, current) {
            return previous.loadingProductId != current.loadingProductId ||
                previous.cartQuantities != current.cartQuantities;
          },
          builder: (context, state) {
            final bool isLoading = state.loadingProductId == widget.product.id;

            final bool isInCart = widget.product.alreadyInCart;

            final num quantity = state.cartQuantities[widget.product.id] ?? 1;

            // Keyboard-safe padding
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;

            // ==========================================================
            // GO TO CART / QUANTITY
            // ==========================================================

            if (isInCart) {
              return AnimatedPadding(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                padding: EdgeInsets.fromLTRB(
                  AppSizes.p24,
                  AppSizes.p12,
                  AppSizes.p24,
                  AppSizes.p24 + bottomInset,
                ),
                child: CommonQuantitySelector(
                  height: AppSizes.s45,
                  padding: AppSizes.p8,
                  radius: AppSizes.r12,
                  minQuantity: 0,
                  maxQuantity: widget.product.totalStock.onHand.toInt(),
                  onQuantityChanged: (newQuantity) {
                    if (newQuantity <= 1) {
                      bloc.add(
                        RemoveProductFromCart(productId: widget.product.id),
                      );
                      context.read<CartBloc>().add(
                        RemoveCart(
                          lineId: state.lineIds[widget.product.id]!.toInt(),
                        ),
                      );
                    } else {
                      if (newQuantity != quantity.toInt()) {
                        bloc.add(
                          SetProductQuantity(
                            productId: widget.product.id,
                            quantity: newQuantity,
                          ),
                        );
                      }
                    }
                  },
                  onDecrease: quantity <= 1
                      ? () {
                          bloc.add(
                            RemoveProductFromCart(productId: widget.product.id),
                          );
                          context.read<CartBloc>().add(
                            RemoveCart(
                              lineId: state.lineIds[widget.product.id]!.toInt(),
                            ),
                          );
                        }
                      : () {
                          bloc.add(
                            DecreaseProductQuantity(
                              productId: widget.product.id,
                            ),
                          );
                        },
                  onIncrease: () {
                    bloc.add(
                      IncreaseProductQuantity(productId: widget.product.id),
                    );
                  },
                  quantity: quantity.toInt(),
                ),
              );
            }

            // ==========================================================
            // ADD TO CART
            // ==========================================================

            return Padding(
              padding: const EdgeInsets.all(AppSizes.p24),
              child: CommonButton(
                isLoading: isLoading,

                onTap: widget.product.alreadyInCart
                    ? () => AppRoutes.pushNamed(RouteNames.cartPage)
                    : () {
                        bloc.add(
                          AddCartEvent(
                            AddCartData(productId: widget.product.id.toInt()),
                          ),
                        );
                      },

                title: AppStringsConstants.addToCart,
              ),
            );
          },
        ),

        /*BlocBuilder<ProductBloc, ProductState>(
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
        ),*/
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CommonNetworkImage(
                  imageUrl: widget.product.image,
                  height: AppSizes.image150,
                ),
              ),

              AppSizes.h20,
              CommonTextWidget(
                title: widget.product.name,
                fontSize: AppSizes.f16,
                fontWeight: FontWeight.w700,
              ),
              AppSizes.h12,
              Row(
                children: [
                  Expanded(
                    child: CommonTextWidget(
                      title:
                          '${widget.product.currencySymbol} ${widget.product.listPrice.toStringAsFixed(2)}',
                      fontSize: AppSizes.f16,
                      fontWeight: FontWeight.w700,
                      color: context.primaryRedColor,
                    ),
                  ),
                  Expanded(
                    child: CommonTextWidget(
                      title:
                          '${AppStringsConstants.stock}\t${AppStringsConstants.colon}\t${widget.product.totalStock.onHand.toInt()}',
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
                value: widget.product.internalReference,
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
              if (widget.product.warehouseStock.isNotEmpty) ...[
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
                  itemCount: widget.product.warehouseStock.length,
                  itemBuilder: (context, index) {
                    final warehouse = widget.product.warehouseStock[index];
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
                              value: warehouse.onHand.toInt().toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Extra space so content is not hidden behind the bottom bar
                // when keyboard is open
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 80),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
