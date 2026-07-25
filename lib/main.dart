import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/dependency_injection/bloc_provider_helper.dart';
import 'package:yuri_sale/core/dependency_injection/injection.dart';
import 'package:yuri_sale/core/routes/app_router.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: authBlocProviders(),
      child: MaterialApp(
        navigatorKey: AppRoutes.navigatorKey,
        initialRoute: RouteNames.splash,
        onGenerateRoute: generateRoute,
        title: AppStringsConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'Poppins',useMaterial3: false),
      ),
    );
  }
}
