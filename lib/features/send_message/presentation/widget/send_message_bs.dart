import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/constants/app_validators.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/log_note/presentation/widget/attachment_item.dart';
import 'package:yuri_sale/features/send_message/data/model/send_message.dart';
import 'package:yuri_sale/features/send_message/domain/entities/create_send_message_data.dart';
import 'package:yuri_sale/features/send_message/presentation/bloc/send_message_bloc.dart';
import 'package:yuri_sale/features/send_message/presentation/bloc/send_message_event.dart';
import 'package:yuri_sale/features/send_message/presentation/bloc/send_message_state.dart';

class SendMessageBottomSheet extends StatefulWidget {
  const SendMessageBottomSheet({
    super.key,
    required this.partnerId,
    this.sendMessage,
    required this.toName,
    required this.fromName,
    this.messageType,
  });

  final int partnerId;
  final SendMessageModel? sendMessage;
  final String toName;
  final String fromName;
  final String? messageType;

  @override
  State<SendMessageBottomSheet> createState() => _SendMessageBottomSheetState();
}

class _SendMessageBottomSheetState extends State<SendMessageBottomSheet> {
  late final TextEditingController _controller;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    var bloc = context.read<SendMessageBloc>();
    bloc.add(ResetAttachmentEvent());
    _controller = TextEditingController(
      text: widget.sendMessage?.bodyPlainText ?? '',
    );

    if (widget.sendMessage != null &&
        widget.sendMessage!.bodyPlainText.isNotEmpty) {
      bloc.add(UpdateMessageTextEvent(widget.sendMessage!.bodyPlainText));
    }
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

          context.read<SendMessageBloc>().add(AddAttachmentEvent(attachment));
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
    final bloc = context.read<SendMessageBloc>();

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
              child: BlocBuilder<SendMessageBloc, SendMessageState>(
                builder: (context, state) {
                  final attachments = state.attachments;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: AppSizes.s50,
                          height: AppSizes.s4,
                          decoration: BoxDecoration(
                            color: context.greyC8,
                            borderRadius: BorderRadius.circular(AppSizes.r16),
                          ),
                        ),
                      ),
                      AppSizes.h24,

                      // To: recipient
                      Wrap(
                        children: [
                          CommonTextWidget(
                            title:
                                '${AppStringsConstants.from}\t${AppStringsConstants.colon}\t',
                            fontSize: AppSizes.f14,
                            fontWeight: FontWeight.w500,
                            color: context.grey89,
                          ),
                          AppSizes.w4,
                          CommonTextWidget(
                            title: widget.fromName,
                            fontSize: AppSizes.f14,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      AppSizes.h12,
                      Wrap(
                        children: [
                          CommonTextWidget(
                            title:
                                '${AppStringsConstants.to}\t${AppStringsConstants.colon}\t',
                            fontSize: AppSizes.f14,
                            fontWeight: FontWeight.w500,
                            color: context.grey89,
                          ),
                          AppSizes.w4,
                          CommonTextWidget(
                            title: widget.toName,
                            fontSize: AppSizes.f14,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      AppSizes.h24,

                      // Avatar + Text Field
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              radius: AppSizes.icon14,
                              backgroundColor: context.primaryRedColor,
                              child: CommonTextWidget(
                                title: 'A',
                                fontSize: AppSizes.f14,
                                fontWeight: FontWeight.w700,
                                color: context.white,
                              ),
                            ),
                          ),
                          AppSizes.w12,
                          Expanded(
                            child: CommonTextFormField(
                              controller: _controller,
                              labelText: AppStringsConstants.sendAMessage,
                              onChanged: (text) {
                                bloc.add(UpdateMessageTextEvent(text));
                              },
                              validator: (value) => AppValidators.requiredField(
                                value,
                                AppStringsConstants.sendAMessage,
                              ),
                            ),
                          ),
                          AppSizes.w12,
                          CommonIconWidget(
                            icon: Icons.attach_file,
                            onTap: _pickFiles,
                          ),
                        ],
                      ),
                      // Attachments preview (horizontal images)
                      if (attachments.isNotEmpty) ...[
                        AppSizes.h14,
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

                      AppSizes.h24,
                      // Send row
                      CommonButton(
                        isLoading: state.isLoading,
                        title: AppStringsConstants.sendMessage,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            final text = _controller.text.trim();
                            if (text.isEmpty) return;
                            AppRoutes.pop(context);
                            final data = CreateSendMessageData(
                              partnerId: widget.partnerId,
                              messageId: widget.sendMessage?.messageId,
                              messageType:
                                  widget.messageType ??
                                  AppStringsConstants.emailL,
                              subject: '',
                              body: text,
                              attachments: List<AttachmentData>.from(
                                attachments,
                              ),
                            );
                            if (widget.sendMessage == null) {
                              bloc.add(CreateSendMessageEvent(data: data));
                            } else {
                              bloc.add(UpdateSendMessageEvent(data: data));
                            }
                          }
                        },
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
