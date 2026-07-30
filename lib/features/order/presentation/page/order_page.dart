import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/features/customer/presentation/widget/customer_card.dart';
import 'package:yuri_sale/features/order/domain/entities/order_data.dart';
import 'package:yuri_sale/features/order/domain/entities/search_order_data.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_bloc.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_event.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_state.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_card.dart';

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
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        leading: widget.data.backButtonShow ? null : AppSizes.h0,
        title: widget.data.backButtonShow ? AppStringsConstants.orders : '',

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSizes.hS100),
          child: Container(
            height: AppSizes.hS45,
            margin: EdgeInsets.symmetric(vertical: AppSizes.p24),
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
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
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return state.isLoading
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
                );
        },
      ),
    );
  }
}
