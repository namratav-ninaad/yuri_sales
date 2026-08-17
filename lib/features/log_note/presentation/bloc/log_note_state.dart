import 'package:equatable/equatable.dart';
import 'package:yuri_sale/features/log_note/data/model/log_note.dart';
import 'package:yuri_sale/features/log_note/domain/entities/create_log_note_data.dart';

class LogNoteState extends Equatable {
  final bool isLoading;
  final bool isActionLoading;
  final bool isSuccess;
  final List<LogNoteModel> logNotes;
  final String? errorMessage;
  final String? successMessage;
  final List<AttachmentData> attachments;
  final String noteText;
  final String logoName;

  const LogNoteState({
    this.isLoading = false,
    this.isActionLoading = false,
    this.isSuccess = false,
    this.logNotes = const [],
    this.errorMessage,
    this.successMessage,
    this.attachments = const [],
    this.noteText = '',
    this.logoName = '',
  });

  LogNoteState copyWith({
    bool? isLoading,
    bool? isActionLoading,
    bool? isSuccess,
    List<LogNoteModel>? logNotes,
    String? errorMessage,
    String? successMessage,
    List<AttachmentData>? attachments,
    String? noteText,
    String? logoName,
  }) {
    return LogNoteState(
      isLoading: isLoading ?? this.isLoading,
      noteText: noteText ?? this.noteText,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      isSuccess: isSuccess ?? false,
      attachments: attachments ?? this.attachments,
      logNotes: logNotes ?? this.logNotes,
      errorMessage: errorMessage,
      successMessage: successMessage,
      logoName: logoName ?? this.logoName,
    );
  }

  @override
  List<Object?> get props => [
    noteText,
    logoName,
    isLoading,
    isActionLoading,
    attachments,
    isSuccess,
    logNotes,
    errorMessage,
    successMessage,
  ];
}
