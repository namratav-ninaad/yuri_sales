import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.pop(context);
      },
      child: Icon(
        Icons.arrow_back_ios_new,
        size: AppSizes.icon20,
        color: AppColorsConstants.black,
      ),
    );
  }
}
