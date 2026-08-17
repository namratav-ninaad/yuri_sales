import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/order/domain/entities/search_order_data.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_bloc.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_event.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_state.dart';

class OrderFilterBottomSheet extends StatelessWidget {
  const OrderFilterBottomSheet({super.key, this.partnerId});

  final int? partnerId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        final bloc = context.read<OrderBloc>();

        return Padding(
          padding: const EdgeInsets.all(AppSizes.p20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonTextWidget(
                    title: AppStringsConstants.filterByStatus,
                    fontSize: AppSizes.f16,
                    fontWeight: FontWeight.w700,
                  ),
                  GestureDetector(
                    onTap: () {
                      bloc.add(OrderStatusFilterChanged(null));
                      bloc.add(
                        FetchOrdersEvent(
                          data: SearchOrderData(
                            partnerId: partnerId,
                            name: '',
                            status: null,
                          ),
                        ),
                      );
                      AppRoutes.pop();
                    },
                    child: CommonTextWidget(
                      title: AppStringsConstants.clear,
                      fontSize: AppSizes.f12,
                      fontWeight: FontWeight.w700,
                      color: context.primaryRedColor,
                    ),
                  ),
                ],
              ),

              AppSizes.h16,

              RadioGroup<OrderStatus>(
                groupValue: state.selectedStatus,
                onChanged: (OrderStatus? value) {
                  bloc.add(OrderStatusFilterChanged(value));
                  bloc.add(
                    FetchOrdersEvent(
                      data: SearchOrderData(
                        partnerId: partnerId,
                        name: '',
                        status: value,
                      ),
                    ),
                  );

                  AppRoutes.pop();
                },
                child: Column(
                  children: OrderStatus.values.map((status) {
                    return RadioListTile<OrderStatus>(
                      value: status,
                      activeColor: context.primaryRedColor,
                      title: CommonTextWidget(
                        title: status.label,
                        fontSize: AppSizes.f14,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
