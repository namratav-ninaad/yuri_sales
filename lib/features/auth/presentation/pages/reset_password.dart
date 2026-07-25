import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/constants/app_validators.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_back_button.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/reset_password/reset_password_event.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/reset_password/reset_password_state.dart';
import 'package:yuri_sale/features/auth/presentation/widgets/common_logo_image.dart';
import 'package:yuri_sale/features/auth/presentation/widgets/icon_and_text_widget.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      body: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ToastHelper.success(AppStringsConstants.passwordResetMsg);
            // Navigate to Login Screen
            AppRoutes.pushReplacementNamed(RouteNames.login);
          }
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            ToastHelper.error(state.errorMessage!);
          }
        },
        builder: (context, state) {
          var bloc = context.read<ResetPasswordBloc>();
          return Padding(
            padding: const EdgeInsets.all(AppSizes.p24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizes.h24,
                const CommonBackButton(),
                AppSizes.h60,
                const Align(
                  alignment: Alignment.center,
                  child: CommonLogoImage(),
                ),
                AppSizes.h40,

                const CommonTextWidget(
                  title: AppStringsConstants.newCredentials,
                  color: AppColorsConstants.black,
                  fontSize: AppSizes.f24,
                  fontWeight: FontWeight.w700,
                ),
                AppSizes.h4,
                const IconAndTextWidget(
                  title: AppStringsConstants.min8Characters,
                ),
                const IconAndTextWidget(
                  title: AppStringsConstants.AtoZUpperCharacters,
                ),
                const IconAndTextWidget(
                  title: AppStringsConstants.aTozLowerCharacters,
                ),
                const IconAndTextWidget(
                  title: AppStringsConstants.specialCharacters,
                ),
                AppSizes.h32,

                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // New Password Field
                      CommonTextFormField(
                        controller: newPasswordController,
                        obscureText: state.obscureNewPassword,
                        labelText: AppStringsConstants.password,
                        prefixIcon: Icons.lock_outline,
                        validator: AppValidators.password,
                        suffixIcon: CommonIconWidget(
                          onTap: () => bloc.add(ToggleNewPasswordVisibility()),
                          color: AppColorsConstants.black,
                          icon: state.obscureNewPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      AppSizes.h12,

                      // Confirm Password Field
                      CommonTextFormField(
                        controller: confirmPasswordController,
                        obscureText: state.obscureConfirmPassword,
                        labelText: AppStringsConstants.confirmPassword,
                        prefixIcon: Icons.lock_outline,
                        validator: (value) => AppValidators.confirmPassword(
                          value,
                          newPasswordController.text,
                        ),
                        suffixIcon: CommonIconWidget(
                          onTap: () => bloc.add(ToggleNewPasswordVisibility()),
                          color: AppColorsConstants.black,
                          icon: state.obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ],
                  ),
                ),

                AppSizes.h32,

                // Submit Button
                CommonButton(
                  isLoading: state.isLoading,
                  title: AppStringsConstants.submit,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ResetPasswordBloc>().add(
                        ResetPasswordSubmitted(
                          email: email,
                          newPassword: newPasswordController.text.trim(),
                          confirmPassword: confirmPasswordController.text
                              .trim(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
