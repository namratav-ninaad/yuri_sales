import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/send_message/data/model/send_message.dart';
import 'package:yuri_sale/features/send_message/domain/entities/create_send_message_data.dart';

class SendMessageState extends Equatable {
  final bool isLoading;
  final bool isActionLoading;
  final bool isSuccess;
  final List<SendMessageModel> sendMessages;
  final String? errorMessage;
  final String? successMessage;
  final List<AttachmentData> attachments;
  final String noteText;

  const SendMessageState({
    this.isLoading = false,
    this.isActionLoading = false,
    this.isSuccess = false,
    this.sendMessages = const [],
    this.errorMessage,
    this.successMessage,
    this.attachments = const [],
    this.noteText = '',
  });

  SendMessageState copyWith({
    bool? isLoading,
    bool? isActionLoading,
    bool? isSuccess,
    List<SendMessageModel>? sendMessages,
    String? errorMessage,
    String? successMessage,
    List<AttachmentData>? attachments,
    String? noteText,
  }) {
    return SendMessageState(
      isLoading: isLoading ?? this.isLoading,
      noteText: noteText ?? this.noteText,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      isSuccess: isSuccess ?? false,
      attachments: attachments ?? this.attachments,
      sendMessages: sendMessages ?? this.sendMessages,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
    noteText,
    isLoading,
    isActionLoading,
    attachments,
    isSuccess,
    sendMessages,
    errorMessage,
    successMessage,
  ];
}
