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
import 'package:yuri_sale/features/delivery/domain/entities/search_delivery_data.dart';
import 'package:yuri_sale/features/delivery/presentation/bloc/delivery_bloc.dart';
import 'package:yuri_sale/features/delivery/presentation/bloc/delivery_event.dart';
import 'package:yuri_sale/features/delivery/presentation/bloc/delivery_state.dart';
import 'package:yuri_sale/features/delivery/presentation/widget/delivery_card.dart';
import 'package:yuri_sale/features/order/domain/entities/search_order_data.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_card.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key, required this.partnerId});

  final int partnerId;

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DeliveryBloc>().add(ResetDeliveryEvent());
    context.read<DeliveryBloc>().add(
      FetchDeliveriesEvent(
        data: SearchDeliveryData(partnerId: widget.partnerId, deliveryName: ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        title: AppStringsConstants.delivery,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSizes.hS100),
          child: Container(
            height: AppSizes.hS45,
            margin: EdgeInsets.symmetric(vertical: AppSizes.p24),
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
            child: CommonTextFormField(
              onFieldSubmitted: (value) {
                context.read<DeliveryBloc>().add(
                  FetchDeliveriesEvent(
                    data: SearchDeliveryData(
                      partnerId: widget.partnerId,
                      deliveryName: value,
                    ),
                  ),
                );
              },
              prefixIcon: Icons.search_outlined,
              controller: searchController,
              labelText: AppStringsConstants.searchDelivery,
            ),
          ),
        ),
      ),
      body: BlocBuilder<DeliveryBloc, DeliveryState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(child: CommonCircularProgressIndicator())
              : state.deliveries.isEmpty
              ? CommonEmptyText(title: AppStringsConstants.noDeliveryData)
              : ListView.separated(
                  separatorBuilder: (context, index) => AppSizes.h12,
                  shrinkWrap: true,
                  itemCount: state.deliveries.length,
                  itemBuilder: (context, index) => DeliveryCard(
                    delivery: state.deliveries[index],
                    onTap: () => AppRoutes.pushNamed(
                      RouteNames.deliveryDetailPage,
                      arguments: state.deliveries[index],
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
