import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/constants/app_validators.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';

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
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(title: AppStringsConstants.requestToQuote),

      body: Form(
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
                maxLength: 10,
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
              CommonButton(title: AppStringsConstants.submitRequest),
            ],
          ),
        ),
      ),
    );
  }
}
