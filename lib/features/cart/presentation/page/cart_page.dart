import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/features/cart/domain/entities/update_cart_qty.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_event.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_state.dart';
import 'package:yuri_sale/features/cart/presentation/widget/cart_card.dart';
import 'package:yuri_sale/features/cart/presentation/widget/cart_sumary.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCart());
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<CartBloc>();
    return Scaffold(
      backgroundColor: AppColorsConstants.white,
      appBar: CommonAppbarWidget(title: AppStringsConstants.myCart),
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
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            ToastHelper.error(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return state.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child:
                          state.cartData == null ||
                              (state.cartData != null &&
                                  state.cartData!.cartProducts.isEmpty)
                          ? CommonEmptyText(
                              title: AppStringsConstants.cartEmpty,
                            )
                          : ListView.separated(
                              padding: EdgeInsets.all(AppSizes.p24),
                              itemCount: state.cartData!.cartProducts.length,
                              separatorBuilder: (_, _) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSizes.p12,
                                ),
                                child: CommonDivider(),
                              ),
                              itemBuilder: (context, index) {
                                var cartData =
                                    state.cartData!.cartProducts[index];
                                return CartCard(
                                  item: cartData,
                                  onDecrease: () {
                                    if (cartData.qty <= 1) return;

                                    bloc.add(
                                      DecreaseQuantity(
                                        data: UpdateCartQty(
                                          lineId: cartData.line_id.toInt(),
                                          qty: cartData.qty.toInt() - 1,
                                        ),
                                      ),
                                    );
                                  },
                                  onIncrease: () => bloc.add(
                                    IncreaseQuantity(
                                      data: UpdateCartQty(
                                        lineId: cartData.line_id.toInt(),
                                        qty: cartData.qty.toInt() + 1,
                                      ),
                                    ),
                                  ),
                                  onRemove: () => bloc.add(
                                    RemoveCart(
                                      lineId: cartData.line_id.toInt(),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),

                    // Summary + Button
                    Container(
                      decoration: BoxDecoration(
                        color: AppColorsConstants.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColorsConstants.black,
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.p24),
                        child: Column(
                          children: [
                            if (state.cartData != null)
                              CartSummary(
                                subtotal: state.cartData!.amount_untaxed
                                    .toDouble(),
                                vat: state.cartData!.amount_tax.toDouble(),
                                total: state.cartData!.amount_total.toDouble(),
                              ),
                            AppSizes.h24,
                            CommonButton(
                              onTap: () => AppRoutes.pushNamed(
                                RouteNames.requestToQuotePage,
                              ),
                              title: AppStringsConstants.requestToQuote,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
