import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/constants/app_validators.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/customer/data/model/note.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_bloc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_event.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_state.dart';
import 'package:yuri_sale/features/customer/presentation/widget/build_followup_section.dart';
import 'package:yuri_sale/features/customer/presentation/widget/build_type_chip.dart';

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
                  color: context.black,
                ),
                AppSizes.h24,

                // Type Chips
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BuildTypeChip(type: NoteType.text, state: state),
                    // BuildTypeChip(type:NoteType.voice , state: state),
                    BuildTypeChip(type: NoteType.followup, state: state),
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
                ] /*else if (state.selectedNoteType.isVoice) ...[
                  BuildVoiceSection(state: state,bloc: bloc)
                ]*/ else ...[
                  BuildFollowUpSection(state: state, bloc: bloc),
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
}
