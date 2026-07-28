import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_event.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_state.dart';
import 'package:yuri_sale/features/product/domain/entities/add_cart_data.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_bloc.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_event.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_state.dart';
import 'package:yuri_sale/features/product/presentation/widget/product_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, this.backButtonShow = false});

  final bool backButtonShow;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCart());
    context.read<ProductBloc>().add(FetchProductsEvent(''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        leading: widget.backButtonShow ? null : AppSizes.h0,
        title: widget.backButtonShow ? AppStringsConstants.browseProduct : '',
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSizes.hS100),
          child: Container(
            height: AppSizes.hS45,
            margin: EdgeInsets.symmetric(vertical: AppSizes.p24),
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
            child: Row(
              children: [
                Expanded(
                  child: CommonTextFormField(
                    controller: searchController,
                    onFieldSubmitted: (query) {
                      context.read<ProductBloc>().add(
                        FetchProductsEvent(query),
                      );
                    },
                    prefixIcon: Icons.search_outlined,
                    labelText: AppStringsConstants.searchProduct,
                  ),
                ),
                AppSizes.w12,
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () => AppRoutes.pushNamed(RouteNames.cartPage),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppSizes.p8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.greyC8,
                              ),
                              borderRadius: BorderRadius.circular(AppSizes.r12),
                            ),
                            child: CommonIconWidget(
                              icon: Icons.shopping_cart_outlined,
                            ),
                          ),

                          // Red Circular Badge
                          if (state.cartData != null &&
                              state.cartData!.cartProducts.isNotEmpty)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                width: AppSizes.icon16,
                                height: AppSizes.icon16,
                                decoration: const BoxDecoration(
                                  color: AppColorsConstants.red,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: CommonTextWidget(
                                  title: state.cartData!.cartProducts.length
                                      .toString(),
                                  color: context.white,
                                  fontSize: AppSizes.f12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) => state.isLoading
            ? const Center(child: CommonCircularProgressIndicator())
            : state.products.isEmpty
            ? CommonEmptyText(title: AppStringsConstants.noProductData)
            : GridView.builder(
                padding: EdgeInsets.fromLTRB(
                  AppSizes.p24,
                  0,
                  AppSizes.p24,
                  AppSizes.p24,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  var product = state.products[index];
                  return ProductCard(
                    product: product,
                    onTap: product.already_in_cart
                        ? () => AppRoutes.pushNamed(RouteNames.cartPage)
                        : () {
                            context.read<ProductBloc>().add(
                              AddCartEvent(
                                AddCartData(productId: product.id.toInt()),
                              ),
                            );
                            context.read<CartBloc>().add(FetchCart());
                          },
                  );
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
