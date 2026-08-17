import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/features/order/domain/entities/order_data.dart';
import 'package:yuri_sale/features/order/domain/entities/search_order_data.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_bloc.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_event.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_state.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_card.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_filter_bs.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, required this.data});

  final OrderData data;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(ResetOrdersEvent());
    context.read<OrderBloc>().add(
      FetchOrdersEvent(
        data: SearchOrderData(
          partnerId: widget.data.partnerId,
          name: '',
          status: widget.data.status,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.white,
        appBar: CommonAppbarWidget(
          leading: widget.data.backButtonShow ? null : AppSizes.h0,
          title: widget.data.backButtonShow ? AppStringsConstants.orders : '',

          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              widget.data.backButtonShow ? AppSizes.s80 : AppSizes.s100,
            ),
            child: Container(
              height: AppSizes.s45,
              margin: EdgeInsets.symmetric(vertical: AppSizes.p24),
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
              child: Row(
                children: [
                  Expanded(
                    child: CommonTextFormField(
                      onFieldSubmitted: (value) {
                        context.read<OrderBloc>().add(
                          FetchOrdersEvent(
                            data: SearchOrderData(
                              partnerId: widget.data.partnerId,
                              name: value,
                              status: widget.data.status,
                            ),
                          ),
                        );
                      },
                      prefixIcon: Icons.search_outlined,
                      controller: searchController,
                      labelText: AppStringsConstants.searchOrder,
                    ),
                  ),
                  AppSizes.w12,
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<OrderStatus>(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppSizes.r24),
                          ),
                        ),
                        builder: (_) => SafeArea(
                          top: false,
                          child: OrderFilterBottomSheet(
                            partnerId: widget.data.partnerId,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.p8),
                      decoration: BoxDecoration(
                        // border: Border.all(color: context.greyC8),
                        color: context.greyFA,
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                      ),
                      child: CommonIconWidget(icon: Icons.filter_alt_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<OrderBloc>().add(ResetOrdersEvent());
                context.read<OrderBloc>().add(
                  FetchOrdersEvent(
                    data: SearchOrderData(
                      partnerId: widget.data.partnerId,
                      name: '',
                      status: widget.data.status,
                    ),
                  ),
                );
              },
              child: state.isLoading
                  ? const Center(child: CommonCircularProgressIndicator())
                  : state.orders.isEmpty
                  ? CommonEmptyText(title: AppStringsConstants.noOrderData)
                  : ListView.separated(
                      separatorBuilder: (context, index) => AppSizes.h12,
                      shrinkWrap: true,
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) => OrderCard(
                        order: state.orders[index],
                        onTap: () => AppRoutes.pushNamed(
                          RouteNames.orderDetailPage,
                          arguments: state.orders[index],
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(
                        AppSizes.p24,
                        0,
                        AppSizes.p24,
                        AppSizes.p24,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
