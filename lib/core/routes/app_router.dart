import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/features/auth/presentation/pages/forgot_password.dart';
import 'package:yuri_sale/features/auth/presentation/pages/login_page.dart';
import 'package:yuri_sale/features/auth/presentation/pages/otp_verification.dart';
import 'package:yuri_sale/features/auth/presentation/pages/reset_password.dart';
import 'package:yuri_sale/features/auth/presentation/pages/splash_page.dart';
import 'package:yuri_sale/features/cart/presentation/page/cart_page.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart';
import 'package:yuri_sale/features/customer/presentation/page/create_customer.dart';
import 'package:yuri_sale/features/customer/presentation/page/customer_details.dart';
import 'package:yuri_sale/features/customer/presentation/page/customer_page.dart';
import 'package:yuri_sale/features/home/presentation/page/home_page.dart';
import 'package:yuri_sale/features/product/presentation/page/product_page.dart';
import 'package:yuri_sale/features/profile/presentation/page/change_password_page.dart';
import 'package:yuri_sale/features/profile/presentation/page/edit_profile_page.dart';
import 'package:yuri_sale/features/quote/presentation/page/request_to_quote_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    case RouteNames.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());

    case RouteNames.forgotPassword:
      return MaterialPageRoute(builder: (_) => ForgotPassword());

    case RouteNames.resetPassword:
      final email = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => ResetPassword(email: email));

    case RouteNames.otpVerification:
      final email = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => OtpVerification(email: email));

    case RouteNames.product:
      final backButtonShow = settings.arguments as bool;
      return MaterialPageRoute(
        builder: (_) => ProductPage(backButtonShow: backButtonShow),
      );

    case RouteNames.cartPage:
      return MaterialPageRoute(builder: (_) => CartPage());

    case RouteNames.home:
      return MaterialPageRoute(builder: (_) => HomePage());

    case RouteNames.editProfile:
      return MaterialPageRoute(builder: (_) => EditProfilePage());

    case RouteNames.customer:
      final backButtonShow = settings.arguments as bool;
      return MaterialPageRoute(
        builder: (_) => CustomerPage(backButtonShow: backButtonShow),
      );

    case RouteNames.createCustomer:
      return MaterialPageRoute(builder: (_) => CreateCustomerPage());

    case RouteNames.requestToQuotePage:
      return MaterialPageRoute(builder: (_) => RequestToQuotePage());

    case RouteNames.changePasswordPage:
      return MaterialPageRoute(builder: (_) => ChangePasswordPage());

    case RouteNames.customerDetail:
      final customer = settings.arguments as CustomerModel;
      return MaterialPageRoute(
        builder: (_) => CustomerDetails(customer: customer),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text(AppStringsConstants.routeNotFound)),
        ),
      );
  }
}
