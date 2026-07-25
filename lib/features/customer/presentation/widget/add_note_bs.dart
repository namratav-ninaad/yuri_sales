import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/constants/app_validators.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/customer/data/model/note.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_bloc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_event.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_state.dart';

class AddNoteBottomSheet extends StatefulWidget {
  final Function(Note) onNoteAdded;

  const AddNoteBottomSheet({super.key, required this.onNoteAdded});

  @override
  State<AddNoteBottomSheet> createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  final noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final noteText = context.read<CreateCustomerBloc>().state.noteText;
    if (noteController.text != noteText) {
      noteController.text = noteText;
      noteController.selection = TextSelection.fromPosition(
        TextPosition(offset: noteController.text.length),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCustomerBloc, CreateCustomerState>(
      builder: (context, state) {
        final bloc = context.read<CreateCustomerBloc>();

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: AppSizes.p24,
            right: AppSizes.p24,
            top: AppSizes.p24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                  title: state.note != null
                      ? AppStringsConstants.editNote
                      : AppStringsConstants.newNote,
                  fontSize: AppSizes.f16,
                  fontWeight: FontWeight.w700,
                  color: AppColorsConstants.black,
                ),
                AppSizes.h24,

                // Type Chips
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTypeChip(context, NoteType.text, state),
                    _buildTypeChip(context, NoteType.voice, state),
                    _buildTypeChip(context, NoteType.followup, state),
                  ],
                ),
                AppSizes.h12,

                // Dynamic Content
                if (state.selectedNoteType.isText) ...[
                  CommonTextFormField(
                    onChanged: (text) => bloc.add(UpdateNoteText(text: text)),
                    labelText: AppStringsConstants.notes,
                    maxLines: 5,
                    validator: (value) => AppValidators.requiredField(
                      value,
                      AppStringsConstants.notes,
                    ),
                    controller: noteController,
                  ),
                ] else if (state.selectedNoteType.isVoice) ...[
                  _buildVoiceSection(context, state, bloc),
                ] else ...[
                  _buildFollowUpSection(context, state, bloc),
                ],

                AppSizes.h32,
                CommonButton(
                  title: AppStringsConstants.saveNote,
                  isLoading: state.isSaving,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      bloc.add(
                        SaveNote(
                          onSuccess: (note) {
                            widget.onNoteAdded(note);
                          },
                        ),
                      );
                    }
                  },
                ),
                AppSizes.h20,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypeChip(
    BuildContext context,
    NoteType type,
    CreateCustomerState state,
  ) {
    final isSelected = state.selectedNoteType == type;
    final bloc = context.read<CreateCustomerBloc>();

    return GestureDetector(
      onTap: () => bloc.add(ChangeNoteType(type: type)),
      child: Chip(
        avatar: CommonIconWidget(
          icon: type.icon,
          color: isSelected
              ? AppColorsConstants.white
              : AppColorsConstants.black,
          size: AppSizes.icon16,
        ),
        label: CommonTextWidget(
          title: type.label,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          fontSize: AppSizes.f14,
          color: isSelected
              ? AppColorsConstants.white
              : AppColorsConstants.black,
        ),
        backgroundColor: isSelected
            ? AppColorsConstants.primaryRedColor
            : AppColorsConstants.greyC8.withValues(alpha: 0.1),
      ),
    );
  }

  Widget _buildVoiceSection(
    BuildContext context,
    CreateCustomerState state,
    CreateCustomerBloc bloc,
  ) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: state.isRecording
                ? () => bloc.add(StopRecording())
                : () => bloc.add(StartRecording()),
            child: Container(
              width: AppSizes.icon60,
              height: AppSizes.icon60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: state.isRecording
                    ? AppColorsConstants.primaryRedColor.withValues(alpha: 0.1)
                    : AppColorsConstants.blue.withValues(alpha: 0.1),
              ),
              child: CommonIconWidget(
                icon: state.isRecording ? Icons.stop : Icons.mic,
                size: AppSizes.icon32,
                color: state.isRecording
                    ? AppColorsConstants.primaryRedColor
                    : AppColorsConstants.blue,
              ),
            ),
          ),
          AppSizes.h12,
          CommonTextWidget(
            title: state.isRecording
                ? '${AppStringsConstants.recording} ${state.recordingSeconds} sec'
                : AppStringsConstants.tapToRecord,
            fontSize: AppSizes.f14,
            fontWeight: FontWeight.w700,
            color: AppColorsConstants.black,
          ),
          if (state.recordedDuration.isNotEmpty)
            CommonTextWidget(
              title:
                  '${AppStringsConstants.recorded} ${state.recordedDuration}',
              fontSize: AppSizes.f12,
              fontWeight: FontWeight.w400,
              color: AppColorsConstants.grey89,
            ),
        ],
      ),
    );
  }

  Widget _buildFollowUpSection(
    BuildContext context,
    CreateCustomerState state,
    CreateCustomerBloc bloc,
  ) {
    return ListTile(
      leading: const CommonIconWidget(
        icon: Icons.calendar_today,
        color: AppColorsConstants.black,
      ),
      title: const CommonTextWidget(
        title: AppStringsConstants.selectFollowUpDate,
        fontSize: AppSizes.f14,
        fontWeight: FontWeight.w500,
        color: AppColorsConstants.black,
      ),
      subtitle: CommonTextWidget(
        title: state.selectedNoteDate != null
            ? DateFormat('dd MMM yyyy').format(state.selectedNoteDate!)
            : AppStringsConstants.noDataSelected,
        fontSize: AppSizes.f12,
        fontWeight: FontWeight.w400,
        color: AppColorsConstants.grey89,
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 7)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) {
          bloc.add(SelectFollowUpDate(date: date));
        }
      },
    );
  }
}
