import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/features/send_message/domain/usecases/send_message_uc.dart';
import 'package:yuri_sale/features/send_message/domain/entities/create_send_message_data.dart';
import 'send_message_event.dart';
import 'send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  final FetchSendMessagesUseCase fetchSendMessagesUseCase;
  final CreateSendMessageUseCase createSendMessageUseCase;
  final UpdateSendMessageUseCase updateSendMessageUseCase;
  final DeleteSendMessageUseCase deleteSendMessageUseCase;

  SendMessageBloc({
    required this.fetchSendMessagesUseCase,
    required this.createSendMessageUseCase,
    required this.updateSendMessageUseCase,
    required this.deleteSendMessageUseCase,
  }) : super(const SendMessageState()) {
    on<UpdateMessageTextEvent>(_onUpdateNoteText);
    on<FetchSendMessageEvent>(_onFetchLogNotes);
    on<CreateSendMessageEvent>(_onCreateLogNote);
    on<UpdateSendMessageEvent>(_onUpdateLogNote);
    on<DeleteSendMessageEvent>(_onDeleteLogNote);
    on<AddAttachmentEvent>(_onAddAttachment);
    on<RemoveAttachmentEvent>(_onRemoveAttachment);
    on<ResetSendMessageEvent>(_onResetLogNote);
    on<ResetAttachmentEvent>(_onResetAttachment);
  }

  void _onResetAttachment(
      ResetAttachmentEvent event,
      Emitter<SendMessageState> emit,
      ) {
    emit(state.copyWith(attachments: []));
  }


  void _onUpdateNoteText(
    UpdateMessageTextEvent event,
    Emitter<SendMessageState> emit,
  ) {
    emit(state.copyWith(noteText: event.text));
  }

  void _onResetLogNote(
    ResetSendMessageEvent event,
    Emitter<SendMessageState> emit,
  ) {
    emit(SendMessageState());
  }

  void _onAddAttachment(
    AddAttachmentEvent event,
    Emitter<SendMessageState> emit,
  ) {
    final updatedList = List<AttachmentData>.from(state.attachments)
      ..add(event.attachment);
    emit(state.copyWith(attachments: updatedList));
  }

  void _onRemoveAttachment(
    RemoveAttachmentEvent event,
    Emitter<SendMessageState> emit,
  ) {
    final updatedList = List<AttachmentData>.from(state.attachments)
      ..remove(event.attachment);
    emit(state.copyWith(attachments: updatedList));
  }

  Future<void> _onFetchLogNotes(
    FetchSendMessageEvent event,
    Emitter<SendMessageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await fetchSendMessagesUseCase(partnerId: event.partnerId);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (sendMessages) => emit(state.copyWith(isLoading: false, sendMessages: sendMessages)),
    );
  }

  Future<void> _onCreateLogNote(
    CreateSendMessageEvent event,
    Emitter<SendMessageState> emit,
  ) async {
    emit(state.copyWith(isActionLoading: true, errorMessage: null));

    final result = await createSendMessageUseCase(data: event.data);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (note) {
        ToastHelper.success(AppStringsConstants.sendMessageCreatedMsg);
        add(FetchSendMessageEvent(partnerId: event.data.partnerId));
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }

  Future<void> _onUpdateLogNote(
    UpdateSendMessageEvent event,
    Emitter<SendMessageState> emit,
  ) async {
    emit(state.copyWith(isActionLoading: true, errorMessage: null));

    final result = await updateSendMessageUseCase(data: event.data);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (note) {
        ToastHelper.success(AppStringsConstants.sendMessageUpdatedMsg);
        add(FetchSendMessageEvent(partnerId: event.data.partnerId));
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }

  Future<void> _onDeleteLogNote(
    DeleteSendMessageEvent event,
    Emitter<SendMessageState> emit,
  ) async {
    emit(state.copyWith(isActionLoading: true, errorMessage: null));

    final result = await deleteSendMessageUseCase(messageId: event.messageId);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (activity) {
        ToastHelper.success(AppStringsConstants.sendMessageDeletedMsg);
        add(FetchSendMessageEvent(partnerId: event.partnerId));
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }
}
