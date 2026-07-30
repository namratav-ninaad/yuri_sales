import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_bloc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:yuri_sale/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:yuri_sale/features/delivery/presentation/bloc/delivery_bloc.dart';
import 'package:yuri_sale/features/home/presentation/bloc/home_bloc.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_bloc.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_bloc.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:yuri_sale/features/quote/presentation/bloc/quote_bloc.dart';
import 'injection.dart';

/// Common BlocProvider with GetIt
BlocProvider<T> blocProvider<T extends StateStreamableSource<Object?>>() {
  return BlocProvider<T>(create: (_) => sl<T>(), lazy: true);
}

/// For MultiBlocProvider - Clean & Reusable
List<BlocProvider> authBlocProviders() {
  return [
    blocProvider<LoginBloc>(),
    blocProvider<ForgotPasswordBloc>(),
    blocProvider<OtpBloc>(),
    blocProvider<ResetPasswordBloc>(),
    blocProvider<DashboardBloc>(),
    blocProvider<HomeBloc>(),
    blocProvider<ProductBloc>(),
    blocProvider<CreateCustomerBloc>(),
    blocProvider<CustomerBloc>(),
    blocProvider<CartBloc>(),
    blocProvider<ProfileBloc>(),
    blocProvider<QuoteBloc>(),
    blocProvider<OrderBloc>(),
    blocProvider<InvoiceBloc>(),
    blocProvider<DeliveryBloc>(),
  ];
}
