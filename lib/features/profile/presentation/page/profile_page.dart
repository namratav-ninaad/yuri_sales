import 'dart:convert' show jsonDecode;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/share_preference/share_pref_helper.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/auth/data/model/login_response_model.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_event.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_state.dart';
import 'package:yuri_sale/features/profile/presentation/widgets/common_show_dialog.dart';
import 'package:yuri_sale/features/profile/presentation/widgets/network_image_widget.dart';
import 'package:yuri_sale/features/profile/presentation/widgets/profile_tile.dart';
import 'package:yuri_sale/features/profile/presentation/widgets/theme_bs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(GetProfileEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProfileBloc>();
    return Scaffold(
      backgroundColor: context.white,
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.p24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonCircleAvatar(
                            imageUrl: profileData.profileImage,
                            onEditTap: () =>
                                AppRoutes.pushNamed(RouteNames.editProfile),
                          ),
                          AppSizes.h24,
                          CommonTextWidget(
                            title: profileData.fullName,
                            color: context.black,
                            fontWeight: FontWeight.w700,
                            fontSize: AppSizes.f20,
                          ),
                          AppSizes.h4,
                          CommonTextWidget(
                            title: profileData.email,
                            color: context.grey89,
                            fontWeight: FontWeight.w500,
                            fontSize: AppSizes.f14,
                          ),

                          AppSizes.h4,
                          CommonTextWidget(
                            title: profileData.phone,
                            color: context.grey89,
                            fontWeight: FontWeight.w500,
                            fontSize: AppSizes.f14,
                          ),
                        ],
                      );
              },
            ),
            AppSizes.h32,
            CommonDivider(),
            ProfileTile(
              onTap: () => AppRoutes.pushNamed(RouteNames.changePasswordPage),
              icon: Icons.lock_outline,
              title: AppStringsConstants.changePassword,
            ),

            /*  ProfileTile(
              onTap: () {},
              icon: Icons.notifications_none,
              title: AppStringsConstants.notification,
            ),
            ProfileTile(
              onTap: () {},
              icon: Icons.language,
              title: AppStringsConstants.language,
            ),*/
            ProfileTile(
              onTap: () {
                showThemeBottomSheet(context);
              },
              icon: Icons.dark_mode_outlined,
              title: AppStringsConstants.theme,
            ),
            ProfileTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => CommonShowDialog(
                    icon: Icons.delete_outline,
                    title: AppStringsConstants.deleteAccount,
                    textDescription:
                        AppStringsConstants.deleteAccountDescription,
                    leftButton: AppStringsConstants.delete,
                    onLogout: () async {
                      final loginJson = await SharedPrefHelper.getString(
                        AppStringsConstants.loginResponse,
                      );
                      if (loginJson != null && loginJson.isNotEmpty) {
                        final loginData = LoginModel.fromJson(
                          jsonDecode(loginJson),
                        );
                        AppRoutes.pop();
                        bloc.add(DeleteAccountEvent(loginData.userId));
                      }
                    },
                  ),
                );
              },
              icon: Icons.delete_outline,
              title: AppStringsConstants.deleteAccount,
            ),
            /* ProfileTile(
              onTap: () {},
              icon: Icons.support_agent,
              title: AppStringsConstants.support,
            ),*/
            ProfileTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => CommonShowDialog(
                    onLogout: () {
                      AppRoutes.pop();
                      bloc.add(LogoutEvent());
                    },
                  ),
                );
              },
              icon: Icons.logout,
              title: AppStringsConstants.logout,
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}
