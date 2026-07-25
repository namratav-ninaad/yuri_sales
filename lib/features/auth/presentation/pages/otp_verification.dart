import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter/services.dart'; // For digits only
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_back_button.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/otp/otp_event.dart';
import 'package:yuri_sale/features/auth/presentation/bloc/otp/otp_state.dart';
import 'package:yuri_sale/features/auth/presentation/widgets/common_logo_image.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key, required this.email});

  final String email;

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<OtpBloc>().add(StartOtpTimer());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ToastHelper.success(AppStringsConstants.otpVerifiedMsg);

            AppRoutes.pushReplacementNamed(
              RouteNames.resetPassword,
              arguments: widget.email,
            );
          }

          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            ToastHelper.error(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(AppSizes.p24),
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

                CommonTextWidget(
                  title: AppStringsConstants.otpVerificationTitle,
                  color: AppColorsConstants.black,
                  fontSize: AppSizes.f24,
                  fontWeight: FontWeight.w700,
                ),
                AppSizes.h4,
                CommonTextWidget(
                  title:
                      '${AppStringsConstants.otpDescription} ${widget.email}',
                  color: AppColorsConstants.grey89,
                  fontSize: AppSizes.f12,
                  fontWeight: FontWeight.w400,
                ),
                AppSizes.h32,

                // OTP Field
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    return OtpTextField(
                      autoFocus: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      fieldWidth: AppSizes.hS52,
                      fieldHeight: AppSizes.hS52,
                      numberOfFields: 6,
                      borderColor: AppColorsConstants.primaryRedColor,
                      focusedBorderColor: AppColorsConstants.primaryRedColor,
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                      showFieldAsBox: true,
                      onCodeChanged: (code) {
                        context.read<OtpBloc>().add(OtpChanged(code));
                      },
                      onSubmit: (code) {
                        context.read<OtpBloc>().add(OtpChanged(code));
                      },
                    );
                  },
                ),

                AppSizes.h8,

                // Error Message
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    if (state.otpError != null && state.otpError!.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: CommonTextWidget(
                          title: state.otpError!,
                          color: AppColorsConstants.primaryRedColor,
                          fontSize: AppSizes.f12,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                AppSizes.h12,

                // Timer / Resend
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: state.canResend
                        ? () => context.read<OtpBloc>().add(ResendOtp())
                        : null,
                    child: CommonTextWidget(
                      title: state.canResend
                          ? AppStringsConstants.resendCode
                          : "00:${state.remainingSeconds.toString().padLeft(2, '0')} mins",
                      color: AppColorsConstants.grey89,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                AppSizes.h40,

                // Verify Button
                CommonButton(
                  isLoading: state.isLoading,
                  title: AppStringsConstants.verifyCode,
                  onTap: () {
                    context.read<OtpBloc>().add(
                      VerifyOtpSubmitted(state.otpValue, widget.email),
                    );
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
