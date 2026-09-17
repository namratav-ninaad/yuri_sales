import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_back_button.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/features/cart/domain/entities/update_cart_qty.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_event.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_state.dart';
import 'package:yuri_sale/features/cart/presentation/widget/cart_card.dart';
import 'package:yuri_sale/features/cart/presentation/widget/cart_sumary.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_bloc.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_event.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(ResetCart());
    context.read<CartBloc>().add(FetchCart(isProductQtySetData: true));
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<CartBloc>();
    return Material(
      color: context.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: context.white,
          appBar: CommonAppbarWidget(
            title: AppStringsConstants.myCart,
            leading: CommonBackButton(
              onTap: () {
                var bloc = context.read<ProductBloc>();
                AppRoutes.pop(context);
                bloc.add(
                  FetchProductsEvent(
                    query: '',
                    categoryId: bloc.state.selectedCategory?.id == 0
                        ? null
                        : bloc.state.selectedCategory?.id ?? 0,
                  ),
                );
              },
            ),
          ),
          body: BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {
              // ========== SUCCESS MESSAGES ==========
              if (state.isQuantityUpdated) {
                ToastHelper.success(AppStringsConstants.qtyUpdateMsg);
              }

              if (state.isItemRemoved) {
                ToastHelper.success(AppStringsConstants.itemRemoveCartMsg);
              }

              // ========== ERROR MESSAGES ==========
              if (state.errorMessage != null &&
                  state.errorMessage!.isNotEmpty) {
                ToastHelper.error(state.errorMessage!);
              }
            },
            builder: (context, state) {
              return BlocBuilder<ProductBloc, ProductState>(
                builder: (context, productState) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<CartBloc>().add(ResetCart());
                      context.read<CartBloc>().add(FetchCart());
                    },
                    child: state.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : state.cartData == null ||
                              (state.cartData != null &&
                                  state.cartData!.cartProducts.isEmpty)
                        ? CommonEmptyText(title: AppStringsConstants.cartEmpty)
                        : Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(AppSizes.p24),
                                  itemCount:
                                      state.cartData!.cartProducts.length,
                                  separatorBuilder: (_, _) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppSizes.p12,
                                    ),
                                    child: CommonDivider(),
                                  ),
                                  itemBuilder: (context, index) {
                                    var cartData =
                                        state.cartData!.cartProducts[index];
                                    int maxQuantity = 1;
                                    if (productState.products.isNotEmpty) {
                                      maxQuantity = productState.products
                                          .firstWhere(
                                            (e) => e.id == cartData.productId,
                                          )
                                          .totalStock
                                          .onHand
                                          .toInt();
                                    }

                                    return CartCard(
                                      currentCode: state.cartData!.currency,
                                      maxQuantity: maxQuantity,
                                      item: cartData,
                                      onDecrease: () {
                                        if (cartData.qty <= 1) {
                                          bloc.add(
                                            RemoveCart(
                                              lineId: cartData.lineId.toInt(),
                                            ),
                                          );
                                          var productBloc = context
                                              .read<ProductBloc>();
                                          productBloc.add(
                                            FetchProductsEvent(
                                              query: '',
                                              categoryId:
                                                  productBloc
                                                          .state
                                                          .selectedCategory
                                                          ?.id ==
                                                      0
                                                  ? null
                                                  : productBloc
                                                            .state
                                                            .selectedCategory
                                                            ?.id ??
                                                        0,
                                            ),
                                          );
                                        } else {
                                          bloc.add(
                                            DecreaseQuantity(
                                              data: UpdateCartQty(
                                                lineId: cartData.lineId.toInt(),
                                                qty: cartData.qty
                                                    .toInt() /*- 1*/,
                                              ),
                                            ),
                                          );
                                        }
                                      },

                                      onQuantityChanged: (newQuantity) {
                                        if (newQuantity <= 1) {
                                          bloc.add(
                                            RemoveCart(
                                              lineId: cartData.lineId.toInt(),
                                            ),
                                          );
                                          var productBloc = context
                                              .read<ProductBloc>();
                                          productBloc.add(
                                            FetchProductsEvent(
                                              query: '',
                                              categoryId:
                                                  productBloc
                                                          .state
                                                          .selectedCategory
                                                          ?.id ==
                                                      0
                                                  ? null
                                                  : productBloc
                                                            .state
                                                            .selectedCategory
                                                            ?.id ??
                                                        0,
                                            ),
                                          );
                                        } else {
                                          if (newQuantity !=
                                              cartData.qty.toInt()) {
                                            bloc.add(
                                              SetCartQuantity(
                                                productId: cartData.productId
                                                    .toInt(),
                                                quantity: newQuantity,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      onIncrease: () => bloc.add(
                                        IncreaseQuantity(
                                          data: UpdateCartQty(
                                            lineId: cartData.lineId.toInt(),
                                            qty: cartData.qty.toInt() /*+ 1*/,
                                          ),
                                        ),
                                      ),
                                      onRemove: () {
                                        bloc.add(
                                          RemoveCart(
                                            lineId: cartData.lineId.toInt(),
                                          ),
                                        );
                                        var productBloc = context
                                            .read<ProductBloc>();
                                        productBloc.add(
                                          FetchProductsEvent(
                                            query: '',
                                            categoryId:
                                                productBloc
                                                        .state
                                                        .selectedCategory
                                                        ?.id ==
                                                    0
                                                ? null
                                                : productBloc
                                                          .state
                                                          .selectedCategory
                                                          ?.id ??
                                                      0,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),

                              // Summary + Button
                              Container(
                                decoration: BoxDecoration(
                                  color: context.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: context.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      offset: const Offset(0, -4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(AppSizes.p24),
                                  child: Column(
                                    children: [
                                      if (state.cartData != null)
                                        CartSummary(
                                          subtotal:
                                              '${state.cartData!.currency} ${state.cartData!.amountUntaxed}',
                                          vat:
                                              '${state.cartData!.currency} ${state.cartData!.amountTax}',
                                          total:
                                              '${state.cartData!.currency} ${state.cartData!.amountTotal}',
                                        ),
                                      AppSizes.h24,
                                      CommonButton(
                                        onTap: () => AppRoutes.pushNamed(
                                          RouteNames.requestToQuotePage,
                                        ),
                                        title:
                                            AppStringsConstants.requestToQuote,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
