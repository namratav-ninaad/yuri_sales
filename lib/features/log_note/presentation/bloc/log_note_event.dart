import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/log_note/domain/entities/create_log_note_data.dart';

abstract class LogNoteEvent extends Equatable {
  const LogNoteEvent();

  @override
  List<Object?> get props => [];
}

class FetchLogNotesEvent extends LogNoteEvent {
  final int partnerId;

  const FetchLogNotesEvent({required this.partnerId});

  @override
  List<Object?> get props => [partnerId];
}
class ResetLogNoteEvent extends LogNoteEvent {
  const ResetLogNoteEvent();
}

class ResetAttachmentEvent extends LogNoteEvent {
  const ResetAttachmentEvent();
}

class UpdateLogoNameEvent extends LogNoteEvent {
  final String logoName;

  const UpdateLogoNameEvent(this.logoName);
}

class UpdateNoteTextEvent extends LogNoteEvent {
  final String text;
  const UpdateNoteTextEvent(this.text);
  @override
  List<Object?> get props => [text];
}

class CreateLogNoteEvent extends LogNoteEvent {
  final CreateLogNoteData data;

  const CreateLogNoteEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class UpdateLogNoteEvent extends LogNoteEvent {
  final CreateLogNoteData data;

  const UpdateLogNoteEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class DeleteLogNoteEvent extends LogNoteEvent {
  final int messageId;
  final int partnerId; // needed to refresh list after delete

  const DeleteLogNoteEvent({required this.messageId, required this.partnerId});

  @override
  List<Object?> get props => [messageId, partnerId];
}

class AddAttachmentEvent extends LogNoteEvent {
  final AttachmentData attachment;
  const AddAttachmentEvent(this.attachment);
  @override
  List<Object?> get props => [attachment];
}

class RemoveAttachmentEvent extends LogNoteEvent {
  final AttachmentData attachment;

  const RemoveAttachmentEvent(this.attachment);

  @override
  List<Object?> get props => [attachment];
}