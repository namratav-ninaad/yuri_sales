import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/send_message/domain/entities/create_send_message_data.dart';

abstract class SendMessageEvent extends Equatable {
  const SendMessageEvent();

  @override
  List<Object?> get props => [];
}

class FetchSendMessageEvent extends SendMessageEvent {
  final int partnerId;

  const FetchSendMessageEvent({required this.partnerId});

  @override
  List<Object?> get props => [partnerId];
}

class ResetSendMessageEvent extends SendMessageEvent {
  const ResetSendMessageEvent();
}

class ResetAttachmentEvent extends SendMessageEvent {
  const ResetAttachmentEvent();
}

class UpdateMessageTextEvent extends SendMessageEvent {
  final String text;

  const UpdateMessageTextEvent(this.text);

  @override
  List<Object?> get props => [text];
}

class CreateSendMessageEvent extends SendMessageEvent {
  final CreateSendMessageData data;

  const CreateSendMessageEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class UpdateSendMessageEvent extends SendMessageEvent {
  final CreateSendMessageData data;

  const UpdateSendMessageEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class DeleteSendMessageEvent extends SendMessageEvent {
  final int messageId;
  final int partnerId; // needed to refresh list after delete

  const DeleteSendMessageEvent({
    required this.messageId,
    required this.partnerId,
  });

  @override
  List<Object?> get props => [messageId, partnerId];
}

class AddAttachmentEvent extends SendMessageEvent {
  final AttachmentData attachment;

  const AddAttachmentEvent(this.attachment);

  @override
  List<Object?> get props => [attachment];
}

class RemoveAttachmentEvent extends SendMessageEvent {
  final AttachmentData attachment;

  const RemoveAttachmentEvent(this.attachment);

  @override
  List<Object?> get props => [attachment];
}
