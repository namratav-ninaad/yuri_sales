import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/customer/customer_event.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/customer/customer_state.dart';
import 'package:yuri_sale/features/customer/presentation/widget/customer_card.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key, this.backButtonShow = false});

  final bool backButtonShow;

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CustomerBloc>().add(FetchCustomerEvent(''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsConstants.white,
      appBar: CommonAppbarWidget(
        leading: widget.backButtonShow ? null : AppSizes.h0,
        title: widget.backButtonShow ? AppStringsConstants.customer : '',

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
                    onFieldSubmitted: (value) {
                      context.read<CustomerBloc>().add(
                        FetchCustomerEvent(value),
                      );
                    },
                    prefixIcon: Icons.search_outlined,
                    controller: searchController,
                    labelText: AppStringsConstants.searchCustomer,
                  ),
                ),
                AppSizes.w12,
                GestureDetector(
                  onTap: () => AppRoutes.pushNamed(RouteNames.createCustomer),
                  child: Container(
                    padding: EdgeInsets.all(AppSizes.p8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColorsConstants.greyC8),
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                    ),
                    child: CommonIconWidget(
                      icon: Icons.add_circle_outline,
                      size: AppSizes.icon24,
                      color: AppColorsConstants.primaryRedColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(child: CommonCircularProgressIndicator())
              : state.customers.isEmpty
              ? CommonEmptyText(title: AppStringsConstants.noCustomerData)
              : ListView.separated(
                  separatorBuilder: (context, index) => AppSizes.h12,
                  shrinkWrap: true,
                  itemCount: state.customers.length,
                  itemBuilder: (context, index) => CustomerCard(
                    customer: state.customers[index],
                    onTap: () => AppRoutes.pushNamed(
                      RouteNames.customerDetail,
                      arguments: state.customers[index],
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.p24,
                    0,
                    AppSizes.p24,
                    AppSizes.p12,
                  ),
                );
        },
      ),
    );
  }
}
