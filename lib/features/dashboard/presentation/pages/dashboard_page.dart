import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_images.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_assets_image_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/auth/presentation/widgets/common_logo_image.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/achievement_card.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/customer_tile.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/product_tile.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/section_title.dart';
import 'package:yuri_sale/features/dashboard/presentation/widgets/title_icon_card.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final products = [
    {"name": "Wireless Headphones", "price": "5,620", "sold": "562"},
    {"name": "Smart Watch", "price": "4,230", "sold": "423"},
    {"name": "Bluetooth Speaker", "price": "3,480", "sold": "348"},
    {"name": "Laptop Stand", "price": "2,910", "sold": "291"},
    {"name": "Power Bank", "price": "2,450", "sold": "245"},
  ];

  final customers = [
    {
      "name": "Michael Johnson",
      "email": "michael@example.com",
      "amount": "₹ 4,250",
    },
    {
      "name": "Sarah Williams",
      "email": "sarah@example.com",
      "amount": "₹ 3,250",
    },
    {"name": "David Brown", "email": "david@example.com", "amount": "₹ 3,150"},
    {
      "name": "Jessica Miller",
      "email": "jessica@example.com",
      "amount": "₹ 2,950",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(
        leading: AppSizes.h0,
        title: AppStringsConstants.goToHome,
        icon: CommonLogoImage(
          imageWidth: AppSizes.image120,
          imageHeight: AppSizes.image80,
        ),
        action: [
          CommonAssetsImageWidget(
            imagePath: AppImagesConstants.notificationIcon,
            imageWidth: AppSizes.icon24,
            imageHeight: AppSizes.icon24,
          ),
          AppSizes.w24,
        ],
      ),
      backgroundColor: context.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.p24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget(
              title: AppStringsConstants.welcomeBackUser,
              fontWeight: FontWeight.w700,
              fontSize: AppSizes.f16,
              color: context.black,
            ),
            AppSizes.h4,
            CommonTextWidget(
              title: AppStringsConstants.businessDescription,
              fontWeight: FontWeight.w500,
              fontSize: AppSizes.f12,
              color: context.grey89,
            ),
            AppSizes.h24,

            /// Cards
            Column(
              children: [
                // Top Row - 3 Cards
                SizedBox(
                  height: AppSizes.hS80,
                  child: Row(
                    children: [
                      Expanded(
                        child: TitleIconCard(
                          imagePath: AppImagesConstants.productSoldIcon,
                          title: AppStringsConstants.totalProductSold,
                          value: '1,245',
                        ),
                      ),
                      AppSizes.w12,
                      Expanded(
                        child: TitleIconCard(
                          imagePath: AppImagesConstants.walletIcon,
                          title: AppStringsConstants.revenueGenerated,
                          value: '₹45,780',
                        ),
                      ),
                      AppSizes.w12,
                      Expanded(
                        child: TitleIconCard(
                          title: AppStringsConstants.pendingPayment,
                          value: '₹8,950',
                          imagePath: AppImagesConstants.currencyRupeeIcon,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSizes.h12,

                // Bottom Row 1
                SizedBox(
                  height: AppSizes.hS150,
                  child: Row(
                    children: [
                      Expanded(child: AchievementCard()),
                      AppSizes.w12,
                      Expanded(
                        child: TitleIconCard(
                          title: AppStringsConstants.averageOrderValue,
                          isTopImageShow: true,
                          value: '₹2,850',
                          imagePath: AppImagesConstants.averageChartIcon,
                        ),
                      ),
                      AppSizes.w12,
                      // Bottom Row 2
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: AppSizes.hS80,
                                child: TitleIconCard(
                                  title: AppStringsConstants.conversionRatio,
                                  value: '32.4%',
                                  imagePath:
                                      AppImagesConstants.conversionFilterIcon,
                                ),
                              ),
                            ),
                            AppSizes.h12,
                            Expanded(
                              child: SizedBox(
                                height: AppSizes.hS80,
                                child: TitleIconCard(
                                  title: AppStringsConstants.monthlyTarget,
                                  value: '₹60,000',
                                  imagePath:
                                      AppImagesConstants.monthlyTargetIcon,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSizes.h24,

            SectionTitle(
              title: AppStringsConstants.top10Product,
              onTap: () =>
                  AppRoutes.pushNamed(RouteNames.product, arguments: true),
            ),
            AppSizes.h12,
            ...products.map(
              (e) => ProductTile(
                name: e["name"]!,
                price: e["price"]!,
                sold: e["sold"]!,
              ),
            ),
            AppSizes.h24,
            SectionTitle(
              title: AppStringsConstants.top10Customer,
              onTap: () =>
                  AppRoutes.pushNamed(RouteNames.customer, arguments: true),
            ),
            AppSizes.h12,
            ...customers.map(
              (e) => CustomerTile(
                name: e["name"]!,
                email: e["email"]!,
                amount: e["amount"]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
