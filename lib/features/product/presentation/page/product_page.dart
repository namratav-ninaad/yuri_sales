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
    context.read<CartBloc>().add(FetchCart(isProductQtySetData: true));
    context.read<ProductBloc>().add(FetchCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final screenWidth = mediaQuery.size.width;
    final bool isSmallMobile = screenWidth <= 360;

    final bool isMobile = screenWidth > 360 && screenWidth < 600;

    final bool isTablet = screenWidth >= 600;

    final double horizontalPadding = isSmallMobile
        ? AppSizes.p12
        : isMobile
        ? AppSizes.p16
        : screenWidth * 0.05;

    final int crossAxisCount = isTablet ? 4 : 2;

    final double crossAxisSpacing = isSmallMobile
        ? AppSizes.s8
        : isMobile
        ? AppSizes.s12
        : AppSizes.s16;

    final double mainAxisSpacing = isSmallMobile
        ? AppSizes.s10
        : isMobile
        ? AppSizes.s12
        : AppSizes.s16;

    final double availableWidth =
        screenWidth -
        (horizontalPadding * 2) -
        (crossAxisSpacing * (crossAxisCount - 1));

    final double cardWidth = availableWidth / crossAxisCount;

    final double cardHeight;

    if (isSmallMobile) {
      // Small mobile
      cardHeight = cardWidth * 1.62;
    } else if (isMobile) {
      // Normal mobile
      cardHeight = cardWidth * 1.55;
    } else {
      // Tablet
      cardHeight = cardWidth * 1;
    }

    final double childAspectRatio = cardWidth / cardHeight;

    return Scaffold(
      backgroundColor: context.white,

      // APP BAR
      appBar: CommonAppbarWidget(
        leading: widget.backButtonShow ? null : AppSizes.h0,

        title: widget.backButtonShow ? AppStringsConstants.browseProduct : '',

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            widget.backButtonShow ? AppSizes.s80 : AppSizes.s100,
          ),

          child: Container(
            height: AppSizes.s45,

            margin: EdgeInsets.symmetric(vertical: AppSizes.p24),

            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),

            child: Row(
              children: [
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    return Expanded(
                      child: CommonTextFormField(
                        controller: searchController,

                        onFieldSubmitted: (query) {
                          context.read<ProductBloc>().add(
                            FetchProductsEvent(
                              query: query,
                              categoryId: state.selectedCategory?.id == 0
                                  ? null
                                  : state.selectedCategory?.id,
                            ),
                          );
                        },
                        prefixIcon: Icons.search_outlined,

                        labelText: AppStringsConstants.searchProduct,
                      ),
                    );
                  },
                ),

                AppSizes.w12,

                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        AppRoutes.pushNamed(RouteNames.cartPage);
                      },

                      child: Stack(
                        clipBehavior: Clip.none,

                        children: [
                          Container(
                            padding: EdgeInsets.all(AppSizes.p8),

                            decoration: BoxDecoration(
                              color: context.greyFA,

                              borderRadius: BorderRadius.circular(AppSizes.r12),
                            ),

                            child: CommonIconWidget(
                              icon: Icons.shopping_cart_outlined,
                            ),
                          ),

                          if (state.cartItemCount > 0)
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
                                  title: state.cartItemCount.toString(),

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

      body: BlocListener<CartBloc, CartState>(
        listenWhen: (previous, current) {
          return previous.cartQuantities != current.cartQuantities ||
              previous.lineIds != current.lineIds;
        },
        listener: (context, cartState) {
          if (cartState.cartData != null) {
            if (cartState.cartQuantities.isNotEmpty &&
                cartState.lineIds.isNotEmpty) {
              debugPrint('========== PRODUCT PAGE CART SYNC ==========');
              debugPrint('Cart Quantities: ${cartState.cartQuantities}');
              debugPrint('Line IDs: ${cartState.lineIds}');

              context.read<ProductBloc>().add(
                SyncCartDataToProducts(
                  cartQuantities: cartState.cartQuantities,
                  lineIds: cartState.lineIds,
                ),
              );
            }
          }
        },
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state.isAddCartSuccess) {
              context.read<CartBloc>().add(FetchCart());
            }
          },
          builder: (context, state) {
            return RefreshIndicator(
              edgeOffset: 80,
              onRefresh: () async {
                context.read<CartBloc>().add(
                  FetchCart(isProductQtySetData: true),
                );
                context.read<ProductBloc>().add(FetchCategoriesEvent());
              },
              child: Column(
                children: [
                  // CATEGORY LIST
                  SizedBox(
                    height: AppSizes.s35,

                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,

                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),

                      itemCount: state.categories.length,

                      separatorBuilder: (context, index) => AppSizes.w12,

                      itemBuilder: (context, index) {
                        final category = state.categories[index];

                        final bool isSelected =
                            category == state.selectedCategory;

                        return GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (category.id != state.selectedCategory?.id) {
                              searchController.clear();
                              context.read<ProductBloc>().add(
                                SelectCategoryEvent(category),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSizes.p8,

                              horizontal: AppSizes.p12,
                            ),

                            decoration: BoxDecoration(
                              color: isSelected
                                  ? context.primaryRedColor
                                  : context.greyFA,

                              borderRadius: BorderRadius.circular(AppSizes.r12),
                            ),

                            child: Center(
                              child: CommonTextWidget(
                                title: category.name,

                                fontSize: AppSizes.f12,

                                textAlign: TextAlign.center,

                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,

                                color: isSelected
                                    ? context.white
                                    : context.grey89,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  AppSizes.h24,

                  // PRODUCT GRID
                  Expanded(
                    child: state.isLoading
                        ? const Center(child: CommonCircularProgressIndicator())
                        : state.products.isEmpty
                        ? CommonEmptyText(
                            title: AppStringsConstants.noProductData,
                          )
                        : GridView.builder(
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              0,
                              horizontalPadding,
                              AppSizes.p24,
                            ),

                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,

                                  crossAxisSpacing: crossAxisSpacing,

                                  mainAxisSpacing: mainAxisSpacing,

                                  childAspectRatio: childAspectRatio,
                                ),

                            itemCount: state.products.length,

                            itemBuilder: (context, index) {
                              final product = state.products[index];

                              return ProductCard(
                                product: product,

                                onTapItem: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  final res = await AppRoutes.pushNamed(
                                    RouteNames.productDetail,

                                    arguments: product,
                                  );

                                  if (res == true) {
                                    searchController.clear();
                                  }
                                },

                                onTapAddCart: /*product.alreadyInCart
                                    ? () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        AppRoutes.pushNamed(
                                          RouteNames.cartPage,
                                        );
                                      }
                                    : */ () {
                                  context.read<ProductBloc>().add(
                                    AddCartEvent(
                                      AddCartData(
                                        productId: product.id.toInt(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
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
