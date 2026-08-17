import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/constants/app_validators.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/share_preference/share_pref_helper.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/features/auth/data/model/login_response_model.dart';
import 'package:yuri_sale/features/quote/domain/entity/submit_rfq_data.dart';
import 'package:yuri_sale/features/quote/presentation/bloc/quote_bloc.dart';
import 'package:yuri_sale/features/quote/presentation/bloc/quote_event.dart';
import 'package:yuri_sale/features/quote/presentation/bloc/quote_state.dart';

class RequestToQuotePage extends StatefulWidget {
  const RequestToQuotePage({super.key});

  @override
  State<RequestToQuotePage> createState() => _RequestToQuotePageState();
}

class _RequestToQuotePageState extends State<RequestToQuotePage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final companyController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<QuoteBloc>().add(ResetQuoteEvent());
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    companyController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(title: AppStringsConstants.requestToQuote),

      body: BlocConsumer<QuoteBloc, QuoteState>(
        listenWhen: (prev, curr) =>
            prev.isSuccess != curr.isSuccess ||
            prev.errorMessage != curr.errorMessage,
        listener: (context, state) {
          if (state.isSuccess) {
            ToastHelper.success(AppStringsConstants.requestQuoteMsg);
            AppRoutes.pushNamed(RouteNames.thankYouPage);
          }
          if (state.errorMessage?.isNotEmpty == true) {
            ToastHelper.error(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppSizes.p24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextFormField(
                    labelText: AppStringsConstants.fullName,
                    controller: nameController,
                    prefixIcon: Icons.person,
                    validator: (value) => AppValidators.requiredField(
                      value,
                      AppStringsConstants.fullName,
                    ),
                  ),
                  AppSizes.h12,
                  CommonTextFormField(
                    labelText: AppStringsConstants.email,
                    controller: emailController,
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.email,
                  ),
                  AppSizes.h12,
                  CommonTextFormField(
                    labelText: AppStringsConstants.phoneNumber,
                    keyboardType: TextInputType.phone,
                    maxLength: 9,
                    controller: phoneController,
                    prefixIcon: Icons.call,
                    validator: AppValidators.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  AppSizes.h12,
                  CommonTextFormField(
                    labelText: AppStringsConstants.location,
                    prefixIcon: Icons.location_on_outlined,
                    controller: locationController,
                    validator: (value) => AppValidators.requiredField(
                      value,
                      AppStringsConstants.location,
                    ),
                  ),
                  AppSizes.h12,
                  CommonTextFormField(
                    labelText: AppStringsConstants.companyName,
                    prefixIcon: Icons.business,
                    controller: companyController,
                    validator: (value) => AppValidators.requiredField(
                      value,
                      AppStringsConstants.companyName,
                    ),
                  ),
                  AppSizes.h12,
                  CommonTextFormField(
                    labelText: AppStringsConstants.note,
                    prefixIcon: Icons.edit_note,
                    controller: noteController,
                    maxLines: 3,
                    validator: (value) => AppValidators.requiredField(
                      value,
                      AppStringsConstants.note,
                    ),
                  ),
                  AppSizes.h32,
                  // Submit Button
                  CommonButton(
                    isLoading: state.isLoading,
                    title: AppStringsConstants.submitRequest,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        final loginResponse = await SharedPrefHelper.getString(
                          AppStringsConstants.loginResponse,
                        );
                        int companyId = 0;
                        if (loginResponse != null) {
                          final loginData = LoginModel.fromJson(
                            jsonDecode(loginResponse),
                          );
                          companyId = loginData.companyId;
                        }

                        // ignore: use_build_context_synchronously
                        context.read<QuoteBloc>().add(
                          SubmitRfqEvent(
                            SubmitRfqData(
                              name: nameController.text.trim().toString(),
                              email: emailController.text.trim().toString(),
                              phone: phoneController.text.trim().toString(),
                              location: locationController.text
                                  .trim()
                                  .toString(),
                              company: companyController.text.trim().toString(),
                              companyId: companyId,
                              notes: noteController.text.trim().toString(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
