import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_back_button.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';

class CommonAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CommonAppbarWidget({
    super.key,
    required this.title,
    this.action,
    this.bottom,
    this.leading,
    this.icon,
  });

  final String title;
  final List<Widget>? action;
  final PreferredSizeWidget? bottom;
  final Widget? leading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.white,
      elevation: 0,
      title:
          icon ??
          CommonTextWidget(
            title: title,
            fontSize: AppSizes.f20,
            fontWeight: FontWeight.w700,
            color: context.black,
          ),
      centerTitle: true,
      actions: action,
      leading: leading ?? CommonBackButton(),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    (title.isEmpty ? 0 : kToolbarHeight) + (bottom?.preferredSize.height ?? 0),
  );
}
