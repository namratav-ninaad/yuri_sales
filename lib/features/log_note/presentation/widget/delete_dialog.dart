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
import 'package:yuri_sale/features/log_note/data/model/log_note.dart';
import 'package:yuri_sale/features/log_note/presentation/bloc/log_note_bloc.dart';
import 'package:yuri_sale/features/log_note/presentation/bloc/log_note_event.dart';
import 'package:yuri_sale/features/log_note/presentation/bloc/log_note_state.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required this.note, required this.partnerId});

  final LogNoteModel note;
  final int partnerId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
      ),
      icon: CircleAvatar(
        radius: AppSizes.icon32,
        backgroundColor: context.primaryRedColor.withValues(alpha: 0.1),

        child: CommonIconWidget(
          icon: Icons.delete_outline,
          color: context.primaryRedColor,
          size: AppSizes.icon28,
        ),
      ),
      title: CommonTextWidget(
        title: AppStringsConstants.deleteNote,
        fontSize: AppSizes.f16,
        fontWeight: FontWeight.w700,
      ),
      content: CommonTextWidget(
        title: AppStringsConstants.deleteNoteConfirmMsg,
        textAlign: TextAlign.center,
        fontSize: AppSizes.f14,
        fontWeight: FontWeight.w400,
      ),
      actionsPadding: const EdgeInsets.all(AppSizes.p12),
      actions: [
        BlocBuilder<LogNoteBloc, LogNoteState>(
          builder: (context, state) => Row(
            children: [
              Expanded(
                child: CommonOutlineButton(
                  title: AppStringsConstants.cancel,
                  onTap: () => AppRoutes.pop(),
                ),
              ),
              AppSizes.w12,
              Expanded(
                child: CommonButton(
                  isLoading: state.isLoading,
                  title: AppStringsConstants.delete,
                  onTap: () {
                    AppRoutes.pop();
                    context.read<LogNoteBloc>().add(
                      DeleteLogNoteEvent(
                        messageId: note.messageId,
                        partnerId: partnerId,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
