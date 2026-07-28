import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_outline_button.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_state.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutDialog({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.p24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: AppSizes.icon60,
              width: AppSizes.icon60,
              decoration: BoxDecoration(
                color: context.primaryRedColor.withValues(
                  alpha: 0.1,
                ),
                shape: BoxShape.circle,
              ),
              child: CommonIconWidget(
                icon: Icons.logout_outlined,
                color: context.primaryRedColor,
                size: AppSizes.icon32,
              ),
            ),
            AppSizes.h20,
            CommonTextWidget(
              title: AppStringsConstants.logout,
              color: context.black,
              fontSize: AppSizes.f20,
              fontWeight: FontWeight.w700,
            ),
            AppSizes.h8,
            CommonTextWidget(
              title: AppStringsConstants.logoutAccountMsg,
              textAlign: TextAlign.center,
              color: context.grey89,
              fontSize: AppSizes.f14,
              fontWeight: FontWeight.w500,
            ),
            AppSizes.h24,
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) => CommonButton(
                title: AppStringsConstants.logout,
                isLoading: state.isLoading,
                onTap: onLogout,
              ),
            ),

            AppSizes.h12,
            CommonOutlineButton(
              title: AppStringsConstants.cancel,
              onTap: () => AppRoutes.pop(),
              borderColor: context.primaryRedColor,
              textColor: context.primaryRedColor,
            ),
          ],
        ),
      ),
    );
  }
}
