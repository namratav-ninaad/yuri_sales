import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/constants/app_validators.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_outline_button.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class MarkDoneBottomSheet extends StatefulWidget {
  const MarkDoneBottomSheet({super.key, this.onDone});

  final ValueChanged<String>? onDone;

  @override
  State<MarkDoneBottomSheet> createState() => _MarkDoneBottomSheetState();
}

class _MarkDoneBottomSheetState extends State<MarkDoneBottomSheet> {
  final TextEditingController feedbackController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        decoration: BoxDecoration(
          color: context.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.p24),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.p24,
              AppSizes.p12,
              AppSizes.p24,
              AppSizes.p24,
            ),
            child:Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: AppSizes.s50,
                    height: AppSizes.s4,
                    decoration: BoxDecoration(
                      color: context.greyC8,
                      borderRadius: BorderRadius.circular(AppSizes.r16),
                    ),
                  ),

                  AppSizes.h14,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const CommonTextWidget(
                      title: AppStringsConstants.markDone,
                      fontSize: AppSizes.f16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  AppSizes.h12,
                  CommonTextFormField(
                    controller: feedbackController,
                    maxLines: 5,
                    labelText: AppStringsConstants.feedback,
                    validator: (value) => AppValidators.requiredField(
                      value,
                      AppStringsConstants.feedback,
                    ),
                  ),

                  AppSizes.h14,

                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          title: AppStringsConstants.done,
                          onTap: () {
                            AppRoutes.pop();
                            widget.onDone?.call(feedbackController.text.trim());
                          },
                        ),
                      ),

                      AppSizes.w12,
                      Expanded(
                        child: CommonOutlineButton(
                          title: AppStringsConstants.cancel,
                          onTap: () => AppRoutes.pop(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
