import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/constants/app_validators.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/login/login_event.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/login/login_state.dart';
import 'package:yuri_sale/features/auth/presentation/widgets/common_logo_image.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    context.read<LoginBloc>().add(ResetLoginData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ToastHelper.success(AppStringsConstants.loginMsg);
            AppRoutes.pushReplacementNamed(RouteNames.home);
          }

          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            ToastHelper.error(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppSizes.p24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CommonLogoImage(),
                  AppSizes.h20,

                  CommonTextWidget(
                    title: AppStringsConstants.welcomeBack,
                    color: AppColorsConstants.black,
                    fontSize: AppSizes.f20,
                    fontWeight: FontWeight.w700,
                  ),
                  AppSizes.h4,
                  CommonTextWidget(
                    title: AppStringsConstants.loginContinueAccount,
                    color: AppColorsConstants.grey89,
                    fontSize: AppSizes.f14,
                    fontWeight: FontWeight.w500,
                  ),
                  AppSizes.h32,

                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // Email Field
                        CommonTextFormField(
                          controller: emailController,
                          labelText: AppStringsConstants.email,
                          keyboardType: TextInputType.name,
                          prefixIcon: Icons.email_outlined,
                          validator: (value) => AppValidators.requiredField(
                            value,
                            AppStringsConstants.email,
                          ),
                        ),
                        AppSizes.h12,

                        // Password Field
                        CommonTextFormField(
                          controller: passwordController,
                          obscureText: state.obscurePassword,
                          labelText: AppStringsConstants.password,
                          prefixIcon: Icons.lock_outline,
                          validator: AppValidators.password,
                          suffixIcon: CommonIconWidget(
                            onTap: () => context.read<LoginBloc>().add(
                              TogglePasswordVisibility(),
                            ),

                            color: AppColorsConstants.black,
                            icon: state.obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),

                        AppSizes.h12,

                        // Remember Me + Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor:
                                      AppColorsConstants.primaryRedColor,
                                  value: state.rememberMe,
                                  onChanged: (value) {
                                    context.read<LoginBloc>().add(
                                      ToggleRememberMe(value ?? false),
                                    );
                                  },
                                ),
                                const CommonTextWidget(
                                  title: AppStringsConstants.rememberMe,
                                  color: AppColorsConstants.grey89,
                                  fontSize: AppSizes.f12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                AppRoutes.pushNamed(RouteNames.forgotPassword);
                              },
                              child: const CommonTextWidget(
                                title: AppStringsConstants.forgotPassword,
                                color: AppColorsConstants.primaryRedColor,
                                fontSize: AppSizes.f12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        AppSizes.h32,

                        // Login Button
                        CommonButton(
                          isLoading: state.isLoading,
                          title: AppStringsConstants.login,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                LoginSubmitted(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  rememberMe: state.rememberMe,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  AppSizes.h24,

                  /*  Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColorsConstants.greyC8,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.p12,
                      ),
                      child: CommonTextWidget(
                        title: AppStringsConstants.orContinueWith,
                        color: AppColorsConstants.grey89,
                        fontSize: AppSizes.f16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: AppColorsConstants.greyC8,
                        height: 1,
                      ),
                    ),
                  ],
                ),

                AppSizes.h24,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CommonOutlineButton(
                        title: AppStringsConstants.google,
                        imagePath: AppImagesConstants.googleIcon,
                      ),
                    ),
                    AppSizes.w16,
                    Expanded(
                      child: CommonOutlineButton(
                        title: AppStringsConstants.facebook,
                        imagePath: AppImagesConstants.facebookIcon,
                      ),
                    ),
                  ],
                ),*/

                  /*AppSizes.h24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTextWidget(
                      title: AppStringsConstants.doNotAccount,
                      fontSize: AppSizes.f12,
                      fontWeight: FontWeight.w400,
                      color: AppColorsConstants.grey89,
                    ),
                    AppSizes.w4,
                    CommonTextWidget(
                      title: AppStringsConstants.signUp,
                      fontSize: AppSizes.f12,
                      fontWeight: FontWeight.w700,
                      color: AppColorsConstants.primaryRedColor,
                    ),
                  ],
                ),*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
