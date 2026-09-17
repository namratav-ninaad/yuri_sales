import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_images.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/share_preference/share_pref_helper.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_assets_image_widget.dart';
import 'package:yuri_sale/features/auth/data/model/login_response_model.dart';
import 'package:yuri_sale/features/customer/presentation/page/customer_page.dart';
import 'package:yuri_sale/features/dashboard/presentation/pages/new_dashboard_page.dart';
import 'package:yuri_sale/features/home/presentation/bloc/home_bloc.dart';
import 'package:yuri_sale/features/home/presentation/bloc/home_event.dart';
import 'package:yuri_sale/features/home/presentation/bloc/home_state.dart';
import 'package:yuri_sale/features/order/domain/entities/order_data.dart';
import 'package:yuri_sale/features/order/presentation/page/order_page.dart';
import 'package:yuri_sale/features/product/presentation/page/product_page.dart';
import 'package:yuri_sale/features/profile/presentation/page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int salesOrderId = 0;

  Widget _buildCurrentPage(int index) {
    switch (index) {
      case 0:
        return NewDashboardPage()/*DashboardPage()*/;
      case 1:
        return OrderPage(data: OrderData(saleOrderId:salesOrderId));
      case 2:
        return ProductPage();
      case 3:
        return CustomerPage();
      case 4:
        return ProfilePage();
      default:
        return NewDashboardPage()/*DashboardPage()*/;
    }
  }

  @override
  void initState() {
    context.read<HomeBloc>().add(ResetBottomNavEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final loginJson = await SharedPrefHelper.getString(
        AppStringsConstants.loginResponse,
      );
      if (loginJson != null && loginJson.isNotEmpty) {
        final loginData = LoginModel.fromJson(jsonDecode(loginJson));
        salesOrderId = loginData.userId;
      }
    },);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) =>
          Scaffold(
            backgroundColor: context.white,
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: context.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                backgroundColor: context.white,
                elevation: 1,
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: AppSizes.f12,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: AppSizes.f12,
                ),
                currentIndex: state.selectedIndex,
                selectedItemColor: context.primaryRedColor,
                unselectedItemColor: context.greyA3,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  context.read<HomeBloc>().add(ChangeBottomNavEvent(index));
                },
                items: [
                  BottomNavigationBarItem(
                    icon: CommonAssetsImageWidget(
                      imagePath: AppImagesConstants.homeIcon,
                      imageHeight: AppSizes.icon24,
                      imageWidth: AppSizes.icon24,
                      color: state.selectedIndex == 0
                          ? context.primaryRedColor
                          : context.greyA3,
                    ),
                    label: AppStringsConstants.dashboard,
                  ),
                  BottomNavigationBarItem(
                    icon: CommonAssetsImageWidget(
                      imagePath: AppImagesConstants.ordersIcon,
                      imageHeight: AppSizes.icon24,
                      imageWidth: AppSizes.icon24,
                      color: state.selectedIndex == 1
                          ? context.primaryRedColor
                          : context.greyA3,
                    ),
                    label: AppStringsConstants.orders,
                  ),
                  BottomNavigationBarItem(
                    icon: CommonAssetsImageWidget(
                      imagePath: AppImagesConstants.productsIcon,
                      imageHeight: AppSizes.icon24,
                      imageWidth: AppSizes.icon24,
                      color: state.selectedIndex == 2
                          ? context.primaryRedColor
                          : context.greyA3,
                    ),
                    label: AppStringsConstants.products,
                  ),
                  BottomNavigationBarItem(
                    icon: CommonAssetsImageWidget(
                      imagePath: AppImagesConstants.customersIcon,
                      imageHeight: AppSizes.icon24,
                      imageWidth: AppSizes.icon24,
                      color: state.selectedIndex == 3
                          ? context.primaryRedColor
                          : context.greyA3,
                    ),
                    label: AppStringsConstants.customers,
                  ),
                  BottomNavigationBarItem(
                    icon: CommonAssetsImageWidget(
                      imagePath: AppImagesConstants.profileIcon,
                      imageHeight: AppSizes.icon24,
                      imageWidth: AppSizes.icon24,
                      color: state.selectedIndex == 4
                          ? context.primaryRedColor
                          : context.greyA3,
                    ),
                    label: AppStringsConstants.profile,
                  ),
                ],
              ),
            ),
            body: _buildCurrentPage(state.selectedIndex),
          ),
    );
  }
}
