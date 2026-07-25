import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_images.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/share_preference/share_pref_helper.dart';
import 'package:yuri_sale/core/widgets/common_assets_image_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        final isLogin = await SharedPrefHelper.isLoggedIn();

        if (isLogin) {
          // ignore: use_build_context_synchronously
          AppRoutes.pushReplacementNamed(RouteNames.home);
        } else {
          // ignore: use_build_context_synchronously
          AppRoutes.pushReplacementNamed(RouteNames.login);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImagesConstants.splashBgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //App Logo
            CommonAssetsImageWidget(imagePath: AppImagesConstants.logoIcon),
            //App Title
            CommonTextWidget(title: AppStringsConstants.appName),
          ],
        ),
      ),
    );
  }
}
