import 'package:get_it/get_it.dart';
import 'package:yuri_sale/core/network/dio_client.dart';
import 'package:yuri_sale/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:yuri_sale/features/auth/data/repository/auth_repository.dart';
import 'package:yuri_sale/features/auth/domain/usecases/auth_usecase.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:yuri_sale/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:yuri_sale/features/cart/data/repository/cart_repository.dart';
import 'package:yuri_sale/features/cart/domain/usecases/cart_us.dart';
import 'package:yuri_sale/features/cart/domain/usecases/remove_cart_uc.dart';
import 'package:yuri_sale/features/cart/domain/usecases/update_cart_qty_uc.dart';
import 'package:yuri_sale/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:yuri_sale/features/customer/data/datasource/customer_remote_datasource.dart';
import 'package:yuri_sale/features/customer/data/repository/customer_repository.dart';
import 'package:yuri_sale/features/customer/domain/usecases/company_uc.dart';
import 'package:yuri_sale/features/customer/domain/usecases/contact_tag_uc.dart';
import 'package:yuri_sale/features/customer/domain/usecases/conutry_uc.dart';
import 'package:yuri_sale/features/customer/domain/usecases/create_customer_uc.dart';
import 'package:yuri_sale/features/customer/domain/usecases/customer_uc.dart';
import 'package:yuri_sale/features/customer/domain/usecases/payment_terms_uc.dart';
import 'package:yuri_sale/features/customer/domain/usecases/state_uc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_bloc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:yuri_sale/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:yuri_sale/features/home/presentation/bloc/home_bloc.dart';
import 'package:yuri_sale/features/order/data/datasource/order_remote_datasource.dart';
import 'package:yuri_sale/features/order/data/repository/order_repository.dart';
import 'package:yuri_sale/features/order/domain/usecases/fetch_order_uc.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_bloc.dart';
import 'package:yuri_sale/features/product/data/datasource/product_remote_data_source.dart';
import 'package:yuri_sale/features/product/data/repository/product_repository.dart';
import 'package:yuri_sale/features/product/domain/usecases/add_cart_us.dart';
import 'package:yuri_sale/features/product/domain/usecases/product_usecase.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_bloc.dart';
import 'package:yuri_sale/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:yuri_sale/features/profile/data/repository/profile_repository.dart';
import 'package:yuri_sale/features/profile/data/repository/theme_repository.dart';
import 'package:yuri_sale/features/profile/domain/usecases/change_password_uc.dart';
import 'package:yuri_sale/features/profile/domain/usecases/get_profile_uc.dart';
import 'package:yuri_sale/features/profile/domain/usecases/logout_uc.dart';
import 'package:yuri_sale/features/profile/domain/usecases/update_profile_uc.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:yuri_sale/features/quote/data/datasource/quote_remote_data_source.dart';
import 'package:yuri_sale/features/quote/data/repository/quote_repository.dart';
import 'package:yuri_sale/features/quote/domain/usecase/submit_rfq_usecase.dart';
import 'package:yuri_sale/features/quote/presentation/bloc/quote_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  // BLoCs
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => ForgotPasswordBloc(forgotPasswordUseCase: sl()));
  sl.registerFactory(() => OtpBloc(verifyOtpUseCase: sl()));
  sl.registerFactory(() => ResetPasswordBloc(resetPasswordUseCase: sl()));
  sl.registerFactory(() => DashboardBloc());
  sl.registerFactory(() => HomeBloc());
  sl.registerFactory(() => CustomerBloc(customerUseCase: sl()));
  sl.registerFactory(
    () => CartBloc(
      cartUseCases: sl(),
      updateCartQtyUseCase: sl(),
      removeCartUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ProductBloc(productUseCase: sl(), addCartUseCase: sl()),
  );
  sl.registerFactory(() => QuoteBloc(submitRfqUseCase: sl()));

  sl.registerFactory(() => OrderBloc(fetchOrdersUseCase: sl()));

  sl.registerFactory(
    () => CreateCustomerBloc(
      customerBloc: sl(),
      contactTagUseCase: sl(),
      paymentTermsUseCase: sl(),
      createCustomerUseCase: sl(),
      companyUseCase: sl(),
      countryUseCase: sl(),
      stateUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ProfileBloc(
      repository: sl(),
      homeBloc: sl(),
      changePasswordUseCase: sl(),
      getProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  sl.registerLazySingleton<DioClient>(() => DioClient());

  //Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));

  //Product
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => ProductUseCase(sl()));
  sl.registerLazySingleton(() => AddCartUseCase(sl()));

  //Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepository());
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  //Customer
  sl.registerLazySingleton<CustomerRemoteDatasource>(
    () => CustomerRemoteDatasourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => CustomerUseCase(sl()));
  sl.registerLazySingleton(() => CompanyUseCase(sl()));
  sl.registerLazySingleton(() => ContactTagUseCase(sl()));
  sl.registerLazySingleton(() => CreateCustomerUseCase(sl()));
  sl.registerLazySingleton(() => PaymentTermsUseCase(sl()));
  sl.registerLazySingleton(() => StateUseCase(sl()));
  sl.registerLazySingleton(() => CountryUseCase(sl()));

  //Cart
  sl.registerLazySingleton<CartRemoteDatasource>(
    () => CartRemoteDatasourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
  sl.registerLazySingleton(() => CartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartQtyUseCase(sl()));

  //Quote
  sl.registerLazySingleton<QuoteRemoteDataSource>(
    () => QuoteRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(sl()));
  sl.registerLazySingleton(() => SubmitRfqUseCase(sl()));

  //Order
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));
  sl.registerLazySingleton(() => FetchOrdersUseCase(sl()));
}
