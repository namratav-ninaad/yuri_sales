import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/share_preference/share_pref_helper.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/features/auth/data/model/login_response_model.dart';
import 'package:yuri_sale/features/send_message/data/model/send_message.dart';
import 'package:yuri_sale/features/send_message/domain/entities/send_message_data.dart';
import 'package:yuri_sale/features/send_message/presentation/bloc/send_message_bloc.dart';
import 'package:yuri_sale/features/send_message/presentation/bloc/send_message_event.dart';
import 'package:yuri_sale/features/send_message/presentation/bloc/send_message_state.dart';
import 'package:yuri_sale/features/send_message/presentation/widget/delete_dialog.dart';
import 'package:yuri_sale/features/send_message/presentation/widget/send_message_bs.dart';
import 'package:yuri_sale/features/send_message/presentation/widget/send_message_card.dart';

class SendMessagePage extends StatefulWidget {
  const SendMessagePage({super.key, required this.data});

  final SendMessageData data;

  @override
  State<SendMessagePage> createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SendMessageBloc>().add(
      FetchSendMessageEvent(partnerId: widget.data.partnerId),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _openAddNoteSheet({SendMessageModel? sendMessage}) async {
    final loginResponse = await SharedPrefHelper.getString(
      AppStringsConstants.loginResponse,
    );
    String fromName = '';
    if (loginResponse != null) {
      final loginData = LoginModel.fromJson(jsonDecode(loginResponse));
      fromName = loginData.email;
    }
    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SendMessageBottomSheet(
        messageType: widget.data.email.isEmpty
            ? AppStringsConstants.comment
            : AppStringsConstants.emailL,
        partnerId: widget.data.partnerId,
        sendMessage: sendMessage,
        fromName: fromName,
        toName: widget.data.email.isEmpty
            ? widget.data.name
            : widget.data.email,
      ),
    );
  }

  void _confirmDelete(SendMessageModel note) {
    showDialog(
      context: context,
      builder: (ctx) {
        return DeleteDialogSendMessage(
          sendMessage: note,
          partnerId: widget.data.partnerId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        title: AppStringsConstants.sendMessage,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSizes.s60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.p24,
              0,
              AppSizes.p24,
              AppSizes.p16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CommonTextFormField(
                    controller: searchController,
                    prefixIcon: Icons.search_outlined,
                    labelText: AppStringsConstants.searchSendMessage,
                    onFieldSubmitted: (value) {},
                  ),
                ),
                AppSizes.w12,
                GestureDetector(
                  onTap: () => _openAddNoteSheet(),
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.p12),
                    decoration: BoxDecoration(
                      // border: Border.all(color: context.greyC8),
                      color: context.greyFA,
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                    ),
                    child: CommonIconWidget(
                      icon: Icons.add_circle_outline,
                      size: AppSizes.icon24,
                      color: context.primaryRedColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocConsumer<SendMessageBloc, SendMessageState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ToastHelper.error(state.errorMessage!);
          }
          if (state.isSuccess && state.successMessage != null) {
            ToastHelper.success(state.successMessage!);
          }
        },
        builder: (context, state) {
          List<SendMessageModel> sendMessages = [];
          if (state.sendMessages.isNotEmpty) {
            sendMessages = state.sendMessages
                .where((e) => e.messageType == AppStringsConstants.emailL)
                .toList();
          }
          return state.isLoading
              ? const Center(child: CommonCircularProgressIndicator())
              : sendMessages.isEmpty
              ? CommonEmptyText(title: AppStringsConstants.noSendMessageData)
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.p24,
                    0,
                    AppSizes.p24,
                    AppSizes.p24,
                  ),
                  itemCount: sendMessages.length,
                  separatorBuilder: (_, index) => AppSizes.h12,
                  itemBuilder: (context, index) {
                    final sendMessage = sendMessages[index];
                    return SendMessageCard(
                      sendMessage: sendMessage,
                      onEdit: () => _openAddNoteSheet(sendMessage: sendMessage),
                      onDelete: () => _confirmDelete(sendMessage),
                    );
                  },
                );
        },
      ),
    );
  }
}
