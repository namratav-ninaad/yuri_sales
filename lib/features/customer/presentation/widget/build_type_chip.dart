import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_bloc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_event.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_state.dart';

class BuildTypeChip extends StatelessWidget {
  const BuildTypeChip({super.key, required this.type, required this.state});

  final NoteType type;
  final CreateCustomerState state;

  @override
  Widget build(BuildContext context) {
    final isSelected = state.selectedNoteType == type;
    final bloc = context.read<CreateCustomerBloc>();

    return GestureDetector(
      onTap: () => bloc.add(ChangeNoteType(type: type)),
      child: Chip(
        avatar: CommonIconWidget(
          icon: type.icon,
          color: isSelected ? context.white : context.black,
          size: AppSizes.icon16,
        ),
        label: CommonTextWidget(
          title: type.label,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          fontSize: AppSizes.f14,
          color: isSelected ? context.white : context.black,
        ),
        backgroundColor: isSelected
            ? context.primaryRedColor
            : context.greyFA,
      ),
    );
  }
}
