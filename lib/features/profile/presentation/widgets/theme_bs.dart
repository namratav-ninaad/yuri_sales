import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_event.dart';
import 'package:yuri_sale/features/profile/presentation/bloc/profile_state.dart';

void showThemeBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    // backgroundColor: context.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r24)),
    ),
    builder: (sheetContext) {
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.p24),
            child: RadioGroup<ThemeMode>(
              groupValue: state.themeMode,
              onChanged: (ThemeMode? value) {
                if (value == null) return;

                context.read<ProfileBloc>().add(ChangeThemeEvent(value));
                Navigator.pop(sheetContext);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonTextWidget(
                    title: AppStringsConstants.chooseTheme,
                    color: context.black,
                  ),

                  AppSizes.h24,

                  RadioListTile<ThemeMode>(
                    value: ThemeMode.light,
                    secondary: const CommonIconWidget(icon: Icons.light_mode),
                    title: CommonTextWidget(
                      title: AppStringsConstants.light,
                      color: context.black,
                      fontSize: AppSizes.f14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  RadioListTile<ThemeMode>(
                    value: ThemeMode.dark,
                    secondary: const CommonIconWidget(icon: Icons.dark_mode),
                    title: CommonTextWidget(
                      title: AppStringsConstants.dark,
                      color: context.black,
                      fontSize: AppSizes.f14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  RadioListTile<ThemeMode>(
                    value: ThemeMode.system,
                    secondary: const CommonIconWidget(icon: Icons.settings),
                    title: CommonTextWidget(
                      title: AppStringsConstants.systemDefault,
                      color: context.black,
                      fontSize: AppSizes.f14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
