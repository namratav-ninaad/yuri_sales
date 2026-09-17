import 'package:get_it/get_it.dart';
import 'package:yuri_sale/core/network/dio_client.dart';
import 'package:yuri_sale/features/activity/data/datasource/activity_remote_datasource.dart';
import 'package:yuri_sale/features/activity/data/repository/activity_repository.dart';
import 'package:yuri_sale/features/activity/domain/usecases/activities_uc.dart';
import 'package:yuri_sale/features/activity/presentation/bloc/activity_bloc.dart';
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
import 'package:yuri_sale/features/dashboard/data/datasource/dashboard_remote_data_source.dart';
import 'package:yuri_sale/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:yuri_sale/features/dashboard/domain/usecases/fetch_dashboard_uc.dart';
import 'package:yuri_sale/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:yuri_sale/features/delivery/data/datasource/delivery_remote_data_source.dart';
import 'package:yuri_sale/features/delivery/data/repository/delivery_repository.dart';
import 'package:yuri_sale/features/delivery/domain/usecases/fetch_deliveries_uc.dart';
import 'package:yuri_sale/features/delivery/presentation/bloc/delivery_bloc.dart';
import 'package:yuri_sale/features/home/presentation/bloc/home_bloc.dart';
import 'package:yuri_sale/features/invoice/data/datasource/invoice_remote_datasource.dart';
import 'package:yuri_sale/features/invoice/data/repository/invoice_repository.dart';
import 'package:yuri_sale/features/invoice/domain/usecases/fetach_invoice_uc.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:yuri_sale/features/log_note/data/datasource/log_note_remote_data_source.dart';
import 'package:yuri_sale/features/log_note/data/repository/log_note_repository.dart';
import 'package:yuri_sale/features/log_note/domain/usecases/log_note_uc.dart';
import 'package:yuri_sale/features/log_note/presentation/bloc/log_note_bloc.dart';
import 'package:yuri_sale/features/order/data/datasource/order_remote_datasource.dart';
import 'package:yuri_sale/features/order/data/repository/order_repository.dart';
import 'package:yuri_sale/features/order/domain/usecases/fetch_order_uc.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_bloc.dart';
import 'package:yuri_sale/features/product/data/datasource/product_remote_data_source.dart';
import 'package:yuri_sale/features/product/data/repository/product_repository.dart';
import 'package:yuri_sale/features/product/domain/usecases/add_cart_uc.dart';
import 'package:yuri_sale/features/product/domain/usecases/category_uc.dart';
import 'package:yuri_sale/features/product/domain/usecases/product_uc.dart';
import 'package:yuri_sale/features/product/presentation/bloc/product_bloc.dart';
import 'package:yuri_sale/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:yuri_sale/features/profile/data/repository/profile_repository.dart';
import 'package:yuri_sale/features/profile/data/repository/theme_repository.dart';
import 'package:yuri_sale/features/profile/domain/usecases/change_password_uc.dart';
import 'package:yuri_sale/features/profile/domain/usecases/delete_account_uc.dart';
import 'package:yuri_sale/features/profile/domain/usecases/get_profile_uc.dart';
import 'package:yuri_sale/features/profile/domain/usecases/logout_uc.dart';
import 'package:yuri_sale/features/profile/domain/usecases/update_profile_uc.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_event.dart';
import 'package:yuri_sale/features/quote/data/datasource/quote_remote_data_source.dart';
import 'package:yuri_sale/features/quote/data/repository/quote_repository.dart';
import 'package:yuri_sale/features/quote/domain/usecase/submit_rfq_usecase.dart';
import 'package:yuri_sale/features/quote/presentation/bloc/quote_bloc.dart';
import 'package:yuri_sale/features/send_message/data/datasource/send_message_remote_data_source.dart';
import 'package:yuri_sale/features/send_message/data/repository/send_message_repository.dart';
import 'package:yuri_sale/features/send_message/domain/usecases/send_message_uc.dart';
import 'package:yuri_sale/features/send_message/presentation/bloc/send_message_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  // BLoCs
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => ForgotPasswordBloc(forgotPasswordUseCase: sl()));
  sl.registerFactory(() => OtpBloc(verifyOtpUseCase: sl()));
  sl.registerFactory(() => ResetPasswordBloc(resetPasswordUseCase: sl()));
  sl.registerFactory(() => DashboardBloc(dashboardUseCase: sl()));
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
    () => ProductBloc(
      productUseCase: sl(),
      addCartUseCase: sl(),
      categoryUseCase: sl(),
      updateCartQtyUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => LogNoteBloc(
      fetchLogNotesUseCase: sl(),
      createLogNotesUseCase: sl(),
      updateLogNotesUseCase: sl(),
      deleteLogNotesUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => SendMessageBloc(
      fetchSendMessagesUseCase: sl(),
      createSendMessageUseCase: sl(),
      updateSendMessageUseCase: sl(),
      deleteSendMessageUseCase: sl(),
    ),
  );
  sl.registerFactory(() => QuoteBloc(submitRfqUseCase: sl()));
  sl.registerFactory(
    () => ActivityBloc(
      activityUseCase: sl(),
      createActivityUseCase: sl(),
      updateActivityUseCase: sl(),
      deleteActivityUseCase: sl(),
      markDoneActivityUseCase: sl(),
      fetchUsersUseCase: sl(),
    ),
  );
  sl.registerFactory(() => InvoiceBloc(fetchInvoiceUseCase: sl()));
  sl.registerFactory(() => DeliveryBloc(fetchDeliveriesUseCase: sl()));
  sl.registerFactory(
    () => OrderBloc(
      fetchOrdersUseCase: sl(),
      fetchQuotationPdfUseCase: sl(),
      shareQuotationPdfUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => CreateCustomerBloc(
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
      deleteAccountUseCase: sl(),
      repository: sl(),
      changePasswordUseCase: sl(),
      getProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      logoutUseCase: sl(),
    )..add(LoadThemeEvent()),
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

  //Dashboard
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => FetchDashboardUseCase(sl()));

  //Product
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => ProductUseCase(sl()));
  sl.registerLazySingleton(() => AddCartUseCase(sl()));
  sl.registerLazySingleton(() => CategoryUseCase(sl()));

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
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));

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
  sl.registerLazySingleton(() => FetchQuotationPdfUseCase(sl()));
  sl.registerLazySingleton(() => ShareQuotationPdfUseCase(sl()));

  //Invoice
  sl.registerLazySingleton<InvoiceRemoteDataSource>(
    () => InvoiceRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<InvoiceRepository>(
    () => InvoiceRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => FetchInvoicesUseCase(sl()));

  //Delivery
  sl.registerLazySingleton<DeliveryRemoteDataSource>(
    () => DeliveryRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<DeliveryRepository>(
    () => DeliveryRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => FetchDeliveriesUseCase(sl()));

  //Activity
  sl.registerLazySingleton<ActivityRemoteDataSource>(
    () => ActivityRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => FetchActivitiesUseCase(sl()));
  sl.registerLazySingleton(() => CreateActivityUseCase(sl()));
  sl.registerLazySingleton(() => UpdateActivityUseCase(sl()));
  sl.registerLazySingleton(() => DeleteActivityUseCase(sl()));
  sl.registerLazySingleton(() => MarkDoneActivityUseCase(sl()));
  sl.registerLazySingleton(() => FetchUsersUseCase(sl()));

  //Log Note
  sl.registerLazySingleton<LogNoteRemoteDataSource>(
    () => LogNoteRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<LogNoteRepository>(
    () => LogNoteRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => FetchLogNotesUseCase(sl()));
  sl.registerLazySingleton(() => CreateLogNoteUseCase(sl()));
  sl.registerLazySingleton(() => UpdateLogNoteUseCase(sl()));
  sl.registerLazySingleton(() => DeleteLogNoteUseCase(sl()));

  //Send Message
  sl.registerLazySingleton<SendMessageRemoteDataSource>(
    () => SendMessageRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<SendMessageRepository>(
    () => SendMessageRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => FetchSendMessagesUseCase(sl()));
  sl.registerLazySingleton(() => CreateSendMessageUseCase(sl()));
  sl.registerLazySingleton(() => UpdateSendMessageUseCase(sl()));
  sl.registerLazySingleton(() => DeleteSendMessageUseCase(sl()));
}
