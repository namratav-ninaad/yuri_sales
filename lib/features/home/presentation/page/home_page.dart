import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_images.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/widgets/common_assets_image_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/customer/presentation/page/customer_page.dart';
import 'package:yuri_sale/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:yuri_sale/features/home/presentation/bloc/home_bloc.dart';
import 'package:yuri_sale/features/home/presentation/bloc/home_event.dart';
import 'package:yuri_sale/features/home/presentation/bloc/home_state.dart';
import 'package:yuri_sale/features/product/presentation/page/product_page.dart';
import 'package:yuri_sale/features/profile/presentation/page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildCurrentPage(int index) {
    switch (index) {
      case 0:
        return DashboardPage();
      case 1:
        return Center(
          child: const CommonTextWidget(
            title: 'Order',
            color: AppColorsConstants.black,
          ),
        );
      case 2:
        return ProductPage();
      case 3:
        return CustomerPage();
      case 4:
        return ProfilePage();
      default:
        return DashboardPage();
    }
  }

  @override
  void initState() {
    context.read<HomeBloc>().add(ResetBottomNavEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Scaffold(
        backgroundColor: AppColorsConstants.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColorsConstants.white,
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
          selectedItemColor: AppColorsConstants.primaryRedColor,
          unselectedItemColor: AppColorsConstants.greyA3,
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
                    ? AppColorsConstants.primaryRedColor
                    : AppColorsConstants.greyA3,
              ),
              label: AppStringsConstants.dashboard,
            ),
            BottomNavigationBarItem(
              icon: CommonAssetsImageWidget(
                imagePath: AppImagesConstants.ordersIcon,
                imageHeight: AppSizes.icon24,
                imageWidth: AppSizes.icon24,
                color: state.selectedIndex == 1
                    ? AppColorsConstants.primaryRedColor
                    : AppColorsConstants.greyA3,
              ),
              label: AppStringsConstants.orders,
            ),
            BottomNavigationBarItem(
              icon: CommonAssetsImageWidget(
                imagePath: AppImagesConstants.productsIcon,
                imageHeight: AppSizes.icon24,
                imageWidth: AppSizes.icon24,
                color: state.selectedIndex == 2
                    ? AppColorsConstants.primaryRedColor
                    : AppColorsConstants.greyA3,
              ),
              label: AppStringsConstants.products,
            ),
            BottomNavigationBarItem(
              icon: CommonAssetsImageWidget(
                imagePath: AppImagesConstants.customersIcon,
                imageHeight: AppSizes.icon24,
                imageWidth: AppSizes.icon24,
                color: state.selectedIndex == 3
                    ? AppColorsConstants.primaryRedColor
                    : AppColorsConstants.greyA3,
              ),
              label: AppStringsConstants.customer,
            ),
            BottomNavigationBarItem(
              icon: CommonAssetsImageWidget(
                imagePath: AppImagesConstants.profileIcon,
                imageHeight: AppSizes.icon24,
                imageWidth: AppSizes.icon24,
                color: state.selectedIndex == 4
                    ? AppColorsConstants.primaryRedColor
                    : AppColorsConstants.greyA3,
              ),
              label: AppStringsConstants.profile,
            ),
          ],
        ),
        body: _buildCurrentPage(state.selectedIndex),
      ),
    );
  }
}
