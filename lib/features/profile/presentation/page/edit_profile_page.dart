import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/profile/domain/entities/update_profile_data.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_event.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_state.dart';
import 'package:yuri_sale/features/profile/presentation/widgets/network_image_widget.dart';
import 'package:yuri_sale/features/profile/presentation/widgets/profile_edit_icon_bs.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final companyController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    fullNameController.dispose();
    companyController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  String cleanMobileNumber(String mobile) {
    // Remove all spaces and special characters
    String cleaned = mobile.replaceAll(RegExp(r'[^0-9]'), '');

    // If number starts with 91 and length is 12 → remove country code
    if (cleaned.startsWith('91') && cleaned.length == 12) {
      cleaned = cleaned.substring(2);
    }

    // If number starts with 0 → remove leading 0
    if (cleaned.startsWith('0') && cleaned.length == 11) {
      cleaned = cleaned.substring(1);
    }

    return cleaned;
  }

  Future<void> _pickImage(ImageSource source) async {
    AppRoutes.pop();
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image != null) {
      context.read<ProfileBloc>().add(PickProfileImageEvent(File(image.path)));
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r24)),
      ),
      builder: (_) => ProfileEditIconBs(onTap: _pickImage),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<ProfileBloc>().state;

      if (state.profile != null) {
        fullNameController.text = state.profile!.full_name;
        companyController.text = state.profile!.company.name;
        emailController.text = state.profile!.email;
        mobileController.text = state.profile!.phone;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsConstants.white,
      appBar: CommonAppbarWidget(title: AppStringsConstants.editProfile),

      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.isLoading && state.profile == null) {
            return CommonCircularProgressIndicator();
          }

          var profileData = state.profile;
          return profileData == null
              ? const Center(
                  child: CommonTextWidget(
                    title: AppStringsConstants.profileDataMsg,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSizes.p24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Profile Picture
                        CommonCircleAvatar(
                          imageFile: state.selectedProfileImage,
                          imageUrl: profileData.profile_image,
                          onEditTap: _showImagePicker,
                        ),

                        AppSizes.h32,
                        CommonTextFormField(
                          controller: fullNameController,
                          labelText: AppStringsConstants.fullName,
                          prefixIcon: Icons.person_outline,
                        ),
                        AppSizes.h12,
                        CommonTextFormField(
                          controller: companyController,
                          labelText: AppStringsConstants.companyName,
                          prefixIcon: Icons.business,
                        ),
                        AppSizes.h12,
                        CommonTextFormField(
                          borderColor: AppColorsConstants.greyF2,
                          fillColor: AppColorsConstants.greyF2,
                          textColor: AppColorsConstants.grey89,
                          controller: emailController,
                          labelText: AppStringsConstants.email,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          readOnly: true,
                          enabled: false,
                          filled: true,
                        ),
                        AppSizes.h12,
                        CommonTextFormField(
                          controller: mobileController,
                          labelText: AppStringsConstants.mobileNumber,
                          maxLength: 10,
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),

                        AppSizes.h24,

                        CommonButton(
                          title: AppStringsConstants.update,
                          isLoading: state.isLoading,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final entity = UpdateProfileData(
                                fullName: fullNameController.text
                                    .trim()
                                    .toString(),
                                companyId: profileData.company.id.toString(),
                                email: emailController.text.trim().toString(),

                                mobileNumber: cleanMobileNumber(
                                  mobileController.text.trim().toString(),
                                ),
                                profileImage: state.selectedProfileImage?.path,
                              );
                              context.read<ProfileBloc>().add(
                                UpdateProfileEvent(entity),
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
