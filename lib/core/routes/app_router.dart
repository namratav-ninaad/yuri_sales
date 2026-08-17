import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/features/activity/domain/entities/edit_activity_data.dart';
import 'package:yuri_sale/features/activity/presentation/page/activity_page.dart';
import 'package:yuri_sale/features/activity/presentation/page/schedule_activity_page.dart';
import 'package:yuri_sale/features/auth/presentation/pages/forgot_password.dart';
import 'package:yuri_sale/features/auth/presentation/pages/login_page.dart';
import 'package:yuri_sale/features/auth/presentation/pages/otp_verification.dart';
import 'package:yuri_sale/features/auth/presentation/pages/reset_password.dart';
import 'package:yuri_sale/features/auth/presentation/pages/splash_page.dart';
import 'package:yuri_sale/features/cart/presentation/page/cart_page.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart'
    show CustomerModel;
import 'package:yuri_sale/features/customer/presentation/page/create_customer.dart';
import 'package:yuri_sale/features/customer/presentation/page/customer_details.dart';
import 'package:yuri_sale/features/customer/presentation/page/customer_page.dart';
import 'package:yuri_sale/features/delivery/data/model/delivery.dart';
import 'package:yuri_sale/features/delivery/presentation/page/delivery_detail.dart';
import 'package:yuri_sale/features/delivery/presentation/page/delivery_page.dart';
import 'package:yuri_sale/features/home/presentation/page/home_page.dart';
import 'package:yuri_sale/features/invoice/domain/entities/invoice_data.dart';
import 'package:yuri_sale/features/invoice/domain/entities/invoice_detail_data.dart';
import 'package:yuri_sale/features/invoice/presentation/page/invoice_details.dart';
import 'package:yuri_sale/features/invoice/presentation/page/invoice_page.dart';
import 'package:yuri_sale/features/log_note/presentation/page/log_note_page.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';
import 'package:yuri_sale/features/order/domain/entities/order_data.dart';
import 'package:yuri_sale/features/order/presentation/page/order_detail.dart';
import 'package:yuri_sale/features/order/presentation/page/order_page.dart';
import 'package:yuri_sale/features/product/data/model/product.dart';
import 'package:yuri_sale/features/product/presentation/page/product_details.dart';
import 'package:yuri_sale/features/product/presentation/page/product_page.dart';
import 'package:yuri_sale/features/profile/presentation/page/change_password_page.dart';
import 'package:yuri_sale/features/profile/presentation/page/edit_profile_page.dart';
import 'package:yuri_sale/features/quote/presentation/page/request_to_quote_page.dart';
import 'package:yuri_sale/features/quote/presentation/page/thank_you_screen.dart';
import 'package:yuri_sale/features/send_message/domain/entities/send_message_data.dart';
import 'package:yuri_sale/features/send_message/presentation/page/send_message_page.dart';

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

    case RouteNames.productDetail:
      final product = settings.arguments as ProductModel;
      return MaterialPageRoute(
        builder: (_) => ProductDetailPage(product: product),
      );

    case RouteNames.cartPage:
      return MaterialPageRoute(builder: (_) => CartPage());

    case RouteNames.home:
      return MaterialPageRoute(builder: (_) => HomePage());

    case RouteNames.editProfile:
      return MaterialPageRoute(builder: (_) => EditProfilePage());

    case RouteNames.activityPage:
      final partnerId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => ActivityPage(partnerId: partnerId),
      );

    case RouteNames.logNotePage:
      final partnerId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => LogNotePage(partnerId: partnerId),
      );

    case RouteNames.sendMessagePage:
      final data = settings.arguments as SendMessageData;
      return MaterialPageRoute(builder: (_) => SendMessagePage(data: data));

    case RouteNames.scheduleActivityPage:
      final data = settings.arguments as EditActivityData;
      return MaterialPageRoute(
        builder: (_) => ScheduleActivityPage(data: data),
      );

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

    case RouteNames.thankYouPage:
      return MaterialPageRoute(builder: (_) => ThankYouPage());

    case RouteNames.invoicePage:
      final data = settings.arguments as InvoiceData;
      return MaterialPageRoute(
        builder: (_) => InvoicePage(data: data),
      );

    case RouteNames.deliveryPage:
      final partnerId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => DeliveryPage(partnerId: partnerId),
      );

    case RouteNames.orderPage:
      final orderData = settings.arguments as OrderData;
      return MaterialPageRoute(builder: (_) => OrderPage(data: orderData));

    case RouteNames.orderDetailPage:
      final orderModel = settings.arguments as OrderModel;
      return MaterialPageRoute(
        builder: (_) => OrderDetail(orderModel: orderModel),
      );

    case RouteNames.invoiceDetailPage:
      final data = settings.arguments as InvoiceDetailData;
      return MaterialPageRoute(
        builder: (_) => InvoiceDetail(data: data),
      );

    case RouteNames.deliveryDetailPage:
      final deliveryModel = settings.arguments as DeliveryModel;
      return MaterialPageRoute(
        builder: (_) => DeliveryDetail(deliveryModel: deliveryModel),
      );

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
