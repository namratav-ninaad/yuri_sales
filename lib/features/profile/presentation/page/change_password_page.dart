import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/constants/app_validators.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_back_button.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_outline_button.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/core/widgets/common_logo_image.dart';
import 'package:yuri_sale/features/auth/presentation/widgets/icon_and_text_widget.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_event.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_state.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final formKey = GlobalKey<FormState>();

  final newPasswordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final oldPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(InitChangePassword());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ToastHelper.success(AppStringsConstants.passwordChangeMsg);
            AppRoutes.pop();
          }
          if (state.error != null && state.error!.isNotEmpty) {
            ToastHelper.error(state.error!);
          }
        },
        builder: (context, state) {
          final bloc = context.read<ProfileBloc>();
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.p24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppSizes.h40,
                Align(
                  alignment: Alignment.centerLeft,
                  child: CommonBackButton(),
                ),
                const CommonLogoImage(),
                AppSizes.h20,
                CommonTextWidget(
                  title: AppStringsConstants.changePassword,
                  color: context.black,
                  fontSize: AppSizes.f24,
                  fontWeight: FontWeight.w700,
                ),
                AppSizes.h4,
                CommonTextWidget(
                  textAlign: TextAlign.center,
                  title: AppStringsConstants.changePasswordDescription,
                  color: context.grey89,
                  fontSize: AppSizes.f14,
                  fontWeight: FontWeight.w400,
                ),
                AppSizes.h12,

                // Password Requirements
                const IconAndTextWidget(
                  title: AppStringsConstants.min8Characters,
                ),
                const IconAndTextWidget(
                  title: AppStringsConstants.atoZUpperCharacters,
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
                      // Old Password Field
                      CommonTextFormField(
                        controller: oldPasswordController,
                        obscureText: state.isOldPasswordVisible,
                        labelText: AppStringsConstants.oldPassword,
                        prefixIcon: Icons.lock_outline,
                        validator: AppValidators.password,
                        onChanged: (value) =>
                            bloc.add(OldPasswordChanged(value)),
                        suffixIcon: CommonIconWidget(
                          onTap: () => bloc.add(ToggleOldPasswordVisibility()),
                          color: context.black,
                          icon: state.isOldPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),

                      AppSizes.h12,
                      // New Password Field
                      CommonTextFormField(
                        controller: newPasswordController,
                        obscureText: state.isNewPasswordVisible,
                        labelText: AppStringsConstants.newPassword,
                        prefixIcon: Icons.lock_outline,
                        validator: AppValidators.password,
                        onChanged: (value) =>
                            bloc.add(NewPasswordChanged(value)),
                        suffixIcon: CommonIconWidget(
                          onTap: () => bloc.add(ToggleNewPasswordVisibility()),
                          color: context.black,
                          icon: state.isNewPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),

                      AppSizes.h12,
                      // Confirm Password Field
                      CommonTextFormField(
                        controller: confirmPasswordController,
                        obscureText: state.isConfirmPasswordVisible,
                        labelText: AppStringsConstants.confirmPassword,
                        prefixIcon: Icons.lock_outline,
                        onChanged: (value) =>
                            bloc.add(ConfirmPasswordChanged(value)),
                        validator: (value) => AppValidators.confirmPassword(
                          value,
                          newPasswordController.text,
                        ),
                        suffixIcon: CommonIconWidget(
                          onTap: () =>
                              bloc.add(ToggleConfirmPasswordVisibility()),
                          color: context.black,
                          icon: state.isConfirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),

                      AppSizes.h40,
                    ],
                  ),
                ),

                CommonButton(
                  isLoading: state.isLoading,
                  title: AppStringsConstants.submit,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      bloc.add(SubmitChangePassword());
                    }
                  },
                ),
                AppSizes.h12,
                CommonOutlineButton(
                  title: AppStringsConstants.cancel,
                  textColor: context.primaryRedColor,
                  borderColor: context.primaryRedColor,
                  fontSize: AppSizes.f14,
                  fontWeight: FontWeight.w700,
                  onTap: () => AppRoutes.pop(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
