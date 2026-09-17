import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/constants/app_validators.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/share_preference/share_pref_helper.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_outline_button.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/auth/data/model/login_response_model.dart';
import 'package:yuri_sale/features/log_note/data/model/log_note.dart';
import 'package:yuri_sale/features/log_note/domain/entities/create_log_note_data.dart'; // or wherever AttachmentData is
import 'package:yuri_sale/features/log_note/presentation/bloc/log_note_bloc.dart';
import 'package:yuri_sale/features/log_note/presentation/bloc/log_note_event.dart';
import 'package:yuri_sale/features/log_note/presentation/bloc/log_note_state.dart';
import 'package:yuri_sale/features/log_note/presentation/widget/attachment_item.dart';

class AddLogNoteBottomSheet extends StatefulWidget {
  const AddLogNoteBottomSheet({super.key, this.note, required this.partnerId});

  final LogNoteModel? note;
  final int partnerId;

  @override
  State<AddLogNoteBottomSheet> createState() => _AddLogNoteBottomSheetState();
}

class _AddLogNoteBottomSheetState extends State<AddLogNoteBottomSheet> {
  late final TextEditingController _controller;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    var bloc = context.read<LogNoteBloc>();
    _controller = TextEditingController(text: widget.note?.bodyPlainText ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final loginResponse = await SharedPrefHelper.getString(
        AppStringsConstants.loginResponse,
      );
      if (loginResponse != null) {
        final loginData = LoginModel.fromJson(jsonDecode(loginResponse));
        bloc.add(UpdateLogoNameEvent(loginData.name));
      }

      bloc.add(ResetAttachmentEvent());

      if (widget.note != null && widget.note!.bodyPlainText.isNotEmpty) {
        bloc.add(UpdateNoteTextEvent(widget.note!.bodyPlainText));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.pickFiles(type: FileType.any);

      if (result.isEmpty) return;

      for (final file in result) {
        try {
          if (file.path == null || file.path!.isEmpty) {
            debugPrint('File path is empty: ${file.name}');
            continue;
          }

          final bytes = await File(file.path!).readAsBytes();
          final base64Content = base64Encode(bytes);

          final attachment = AttachmentData(
            name: file.name,
            mimetype: getMimeType(file.extension ?? ''),
            content: base64Content,
          );

          if (!mounted) return;

          context.read<LogNoteBloc>().add(AddAttachmentEvent(attachment));
        } catch (e) {
          debugPrint('Error reading file ${file.name}: $e');
        }
      }
    } catch (e) {
      debugPrint('Error picking files: $e');
    }
  }

  String getMimeType(String path) {
    final extension = path.split('.').last.toLowerCase();

    switch (extension) {
      case AppStringsConstants.pdfExtension:
        return AppStringsConstants.pdfMimeType;

      case AppStringsConstants.jpgExtension:
      case AppStringsConstants.jpegExtension:
        return AppStringsConstants.jpegMimeType;

      case AppStringsConstants.pngExtension:
        return AppStringsConstants.pngMimeType;

      case AppStringsConstants.docExtension:
        return AppStringsConstants.docMimeType;

      case AppStringsConstants.docxExtension:
        return AppStringsConstants.docxMimeType;

      default:
        return AppStringsConstants.defaultMimeType;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bloc = context.read<LogNoteBloc>();

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: context.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSizes.r24),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.p24,
              AppSizes.p12,
              AppSizes.p24,
              AppSizes.p24,
            ),
            child: Form(
              key: formKey,
              child: BlocBuilder<LogNoteBloc, LogNoteState>(
                builder: (context, state) {
                  final attachments = state.attachments;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Handle bar
                      Container(
                        width: AppSizes.s50,
                        height: AppSizes.s4,
                        decoration: BoxDecoration(
                          color: context.greyC8,
                          borderRadius: BorderRadius.circular(AppSizes.r16),
                        ),
                      ),
                      AppSizes.h14,

                      // Title
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CommonTextWidget(
                          title: widget.note != null
                              ? AppStringsConstants.editNote
                              : AppStringsConstants.logNote,
                          fontSize: AppSizes.f16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppSizes.h16,

                      // Avatar + Text Field
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: AppSizes.icon14,
                            backgroundColor: context.primaryRedColor,
                            child: CommonTextWidget(
                              title: widget.note != null
                                  ? widget.note!.author[0].toUpperCase()
                                  : state.logoName.isNotEmpty
                                  ? state.logoName[0].toUpperCase()
                                  : 'A',
                              fontSize: AppSizes.f14,
                              fontWeight: FontWeight.w700,
                              color: context.white,
                            ),
                          ),
                          AppSizes.w12,
                          Expanded(
                            child: CommonTextFormField(
                              controller: _controller,
                              maxLines: 4,
                              labelText: AppStringsConstants.note,
                              onChanged: (text) {
                                bloc.add(UpdateNoteTextEvent(text));
                              },
                              validator: (value) => AppValidators.requiredField(
                                value,
                                AppStringsConstants.note,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppSizes.h12,

                      // Attachment button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: _pickFiles,
                          icon: Icon(
                            Icons.attach_file,
                            size: 20,
                            color: context.primaryRedColor,
                          ),
                          label: CommonTextWidget(
                            title: AppStringsConstants.addAttachment,
                            fontSize: AppSizes.f14,
                            color: context.primaryRedColor,
                            fontWeight: FontWeight.w600,
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),

                      // Selected attachments
                      if (attachments.isNotEmpty) ...[
                        AppSizes.h12,
                        SizedBox(
                          height: 110,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: attachments.length,
                            itemBuilder: (context, index) {
                              final attachment = attachments[index];

                              return AttachmentItem(
                                attachment: attachment,
                                onRemove: () {
                                  bloc.add(RemoveAttachmentEvent(attachment));
                                },
                              );
                            },
                          ),
                        ),
                      ],

                      AppSizes.h20,

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              isLoading:
                                  state.isActionLoading || state.isLoading,
                              title: widget.note != null
                                  ? AppStringsConstants.update
                                  : AppStringsConstants.logNote,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  final text = state.noteText.trim().isNotEmpty
                                      ? state.noteText.trim()
                                      : _controller.text.trim();
                                  AppRoutes.pop(context);

                                  final data = CreateLogNoteData(
                                    partnerId: widget.partnerId,
                                    messageId: widget.note?.messageId,
                                    messageType: AppStringsConstants.comment,
                                    subject: '',
                                    body: text,
                                    attachments: attachments,
                                  );

                                  if (widget.note == null) {
                                    context.read<LogNoteBloc>().add(
                                      CreateLogNoteEvent(data: data),
                                    );
                                  } else {
                                    context.read<LogNoteBloc>().add(
                                      UpdateLogNoteEvent(data: data),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          AppSizes.w12,
                          Expanded(
                            child: CommonOutlineButton(
                              title: AppStringsConstants.cancel,
                              textColor: context.primaryRedColor,
                              onTap: () {
                                AppRoutes.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
