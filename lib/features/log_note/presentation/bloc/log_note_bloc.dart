import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/features/log_note/domain/usecases/log_note_uc.dart';
import 'package:yuri_sale/features/log_note/domain/entities/create_log_note_data.dart';
import 'log_note_event.dart';
import 'log_note_state.dart';

class LogNoteBloc extends Bloc<LogNoteEvent, LogNoteState> {
  final FetchLogNotesUseCase fetchLogNotesUseCase;
  final CreateLogNoteUseCase createLogNotesUseCase;
  final UpdateLogNoteUseCase updateLogNotesUseCase;
  final DeleteLogNoteUseCase deleteLogNotesUseCase;

  LogNoteBloc({
    required this.fetchLogNotesUseCase,
    required this.createLogNotesUseCase,
    required this.updateLogNotesUseCase,
    required this.deleteLogNotesUseCase,
  }) : super(const LogNoteState()) {
    on<UpdateNoteTextEvent>(_onUpdateNoteText);
    on<FetchLogNotesEvent>(_onFetchLogNotes);
    on<CreateLogNoteEvent>(_onCreateLogNote);
    on<UpdateLogNoteEvent>(_onUpdateLogNote);
    on<DeleteLogNoteEvent>(_onDeleteLogNote);
    on<AddAttachmentEvent>(_onAddAttachment);
    on<RemoveAttachmentEvent>(_onRemoveAttachment);
    on<ResetLogNoteEvent>(_onResetLogNote);
    on<ResetAttachmentEvent>(_onResetAttachment);
    on<UpdateLogoNameEvent>(_onUpdateLogoName);
  }

  void _onResetAttachment(
    ResetAttachmentEvent event,
    Emitter<LogNoteState> emit,
  ) {
    emit(state.copyWith(attachments: [],isLoading: false));
  }

  void _onUpdateLogoName(
      UpdateLogoNameEvent event,
      Emitter<LogNoteState> emit,
      ) {
    emit(state.copyWith(logoName: event.logoName));
  }

  void _onUpdateNoteText(
    UpdateNoteTextEvent event,
    Emitter<LogNoteState> emit,
  ) {
    emit(state.copyWith(noteText: event.text));
  }

  void _onResetLogNote(ResetLogNoteEvent event, Emitter<LogNoteState> emit) {
    emit(LogNoteState());
  }

  void _onAddAttachment(AddAttachmentEvent event, Emitter<LogNoteState> emit) {
    final updatedList = List<AttachmentData>.from(state.attachments)
      ..add(event.attachment);
    emit(state.copyWith(attachments: updatedList));
  }

  void _onRemoveAttachment(
    RemoveAttachmentEvent event,
    Emitter<LogNoteState> emit,
  ) {
    final updatedList = List<AttachmentData>.from(state.attachments)
      ..remove(event.attachment);
    emit(state.copyWith(attachments: updatedList));
  }

  Future<void> _onFetchLogNotes(
    FetchLogNotesEvent event,
    Emitter<LogNoteState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await fetchLogNotesUseCase(partnerId: event.partnerId);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (notes) => emit(state.copyWith(isLoading: false, logNotes: notes)),
    );
  }

  Future<void> _onCreateLogNote(
    CreateLogNoteEvent event,
    Emitter<LogNoteState> emit,
  ) async {
    emit(state.copyWith(isActionLoading: true,isLoading: false,  errorMessage: null));

    final result = await createLogNotesUseCase(data: event.data);

    result.fold(
      (failure) =>
          emit(state.copyWith(isActionLoading: false, isLoading: false, errorMessage: failure.message)),
      (note) {
        ToastHelper.success(AppStringsConstants.logNoteCreatedMsg);
        add(FetchLogNotesEvent(partnerId: event.data.partnerId));
        emit(state.copyWith(isActionLoading: false, isLoading: false, isSuccess: true));
      },
    );
  }

  Future<void> _onUpdateLogNote(
    UpdateLogNoteEvent event,
    Emitter<LogNoteState> emit,
  ) async {
    emit(state.copyWith(isActionLoading: true, errorMessage: null));

    final result = await updateLogNotesUseCase(data: event.data);

    result.fold(
      (failure) =>
          emit(state.copyWith(isActionLoading: false, isLoading: false, errorMessage: failure.message)),
      (note) {
        ToastHelper.success(AppStringsConstants.logNoteUpdatedMsg);
        add(FetchLogNotesEvent(partnerId: event.data.partnerId));
        emit(state.copyWith(isActionLoading: false, isLoading: false, isSuccess: true));
      },
    );
  }

  Future<void> _onDeleteLogNote(
    DeleteLogNoteEvent event,
    Emitter<LogNoteState> emit,
  ) async {
    emit(state.copyWith(isActionLoading: true, errorMessage: null));

    final result = await deleteLogNotesUseCase(messageId: event.messageId);

    result.fold(
      (failure) =>
          emit(state.copyWith(isActionLoading: false, isLoading: false, errorMessage: failure.message)),
      (activity) {
        ToastHelper.success(AppStringsConstants.logNoteDeletedMsg);
        add(FetchLogNotesEvent(partnerId: event.partnerId));
        emit(state.copyWith(isActionLoading: false, isLoading: false, isSuccess: true));
      },
    );
  }
}
