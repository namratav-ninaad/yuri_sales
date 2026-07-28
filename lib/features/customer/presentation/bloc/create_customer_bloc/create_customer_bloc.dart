import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/date_helper.dart';
import 'package:yuri_sale/features/customer/data/model/company_model.dart';
import 'package:yuri_sale/features/customer/data/model/contact_tag.dart';
import 'package:yuri_sale/features/customer/data/model/country.dart';
import 'package:yuri_sale/features/customer/data/model/note.dart';
import 'package:yuri_sale/features/customer/data/model/payment_terms.dart';
import 'package:yuri_sale/features/customer/domain/entities/create_customer_data.dart';
import 'package:yuri_sale/features/customer/domain/usecases/company_uc.dart';
import 'package:yuri_sale/features/customer/domain/usecases/contact_tag_uc.dart';
import 'package:yuri_sale/features/customer/domain/usecases/conutry_uc.dart';
import 'package:yuri_sale/features/customer/domain/usecases/create_customer_uc.dart';
import 'package:yuri_sale/features/customer/domain/usecases/payment_terms_uc.dart';
import 'package:yuri_sale/features/customer/domain/usecases/state_uc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_state.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/customer/customer_event.dart';
import 'create_customer_event.dart';

class CreateCustomerBloc
    extends Bloc<CreateCustomerEvent, CreateCustomerState> {
  Timer? _recordingTimer;
  CreateCustomerUseCase createCustomerUseCase;
  CompanyUseCase companyUseCase;
  PaymentTermsUseCase paymentTermsUseCase;
  ContactTagUseCase contactTagUseCase;
  final CustomerBloc customerBloc;
  CountryUseCase countryUseCase;
  StateUseCase stateUseCase;

  CreateCustomerBloc({
    required this.countryUseCase,
    required this.stateUseCase,
    required this.contactTagUseCase,
    required this.companyUseCase,
    required this.createCustomerUseCase,
    required this.paymentTermsUseCase,
    required this.customerBloc,
  }) : super(CreateCustomerState()) {
    on<ChangeNoteType>(_onChangeNoteType);
    on<UpdateNoteText>(_onUpdateNoteText);
    on<StartRecording>(_onStartRecording);
    on<StopRecording>(_onStopRecording);
    on<TickRecording>(_onTickRecording);
    on<SelectFollowUpDate>(_onSelectFollowUpDate);
    on<SaveNote>(_onSaveNote);
    on<AddNoteEvent>(_addNote);
    on<SelectCompanyEvent>(_onSelectCompany);
    on<AddNewTagEvent>(_onAddNewTag);
    on<RemoveSelectedTagEvent>(_onRemoveSelectedTag);
    on<SelectPaymentTermsEvent>(_onSelectPaymentTerms);
    on<CreateCustomerDataEvent>(_createCustomer);
    on<LoadCustomerDropDownDataEvent>(_onLoadCustomerDropDownData);
    on<AddAttachmentEvent>(_onAddAttachment);
    on<RemoveAttachmentEvent>(_onRemoveAttachment);
    on<ResetCreateDataEvent>(_onResetCreateData);
    on<SelectCountryEvent>(_onSelectCountry);
    on<SelectStateEvent>(_onSelectState);
    on<FetchStateEvent>(_onFetchState);
    on<SelectAddressTypeEvent>(_onSelectAddressType);
  }

  void _onResetCreateData(
    ResetCreateDataEvent event,
    Emitter<CreateCustomerState> emit,
  ) {
    emit(CreateCustomerState());
  }

  void _onSelectAddressType(
    SelectAddressTypeEvent event,
    Emitter<CreateCustomerState> emit,
  ) {
    emit(
      state.copyWith(
        selectedAddressType: event.addressType,
        clearSelectedCountry: true,
        clearSelectedState: true,
      ),
    );
  }

  void _onAddAttachment(
    AddAttachmentEvent event,
    Emitter<CreateCustomerState> emit,
  ) {
    final updatedList = List<AttachmentData>.from(state.attachments)
      ..add(event.attachment);
    emit(state.copyWith(attachments: updatedList));
  }

  void _onRemoveAttachment(
    RemoveAttachmentEvent event,
    Emitter<CreateCustomerState> emit,
  ) {
    final updatedList = List<AttachmentData>.from(state.attachments)
      ..remove(event.attachment);
    emit(state.copyWith(attachments: updatedList));
  }

  Future<void> _onLoadCustomerDropDownData(
    LoadCustomerDropDownDataEvent event,
    Emitter<CreateCustomerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final results = await Future.wait([
      paymentTermsUseCase.call(),
      companyUseCase.call(),
      contactTagUseCase.call(),
      countryUseCase.call(),
    ]);
    final paymentResult = results[0];
    final companyResult = results[1];
    final tagResult = results[2];
    final countryResult = results[3];

    List<CompanyModel>? companies = [];
    List<PaymentTermsModel>? paymentTerms = [];
    List<ContactTagModel>? contactTags = [];
    List<CountryModel>? countries = [];

    companyResult.fold((_) {}, (data) => companies = data.cast<CompanyModel>());

    paymentResult.fold(
      (_) {},
      (data) => paymentTerms = data.cast<PaymentTermsModel>(),
    );

    countryResult.fold((_) {}, (data) async {
      return countries = data.cast<CountryModel>();
    });
    tagResult.fold(
      (_) {},
      (data) => contactTags = data.cast<ContactTagModel>(),
    );

    emit(
      state.copyWith(
        isLoading: false,
        companies: companies,
        paymentTerms: paymentTerms,
        contactTags: contactTags,
        countries: countries,
      ),
    );
  }

  void _onSelectCompany(
    SelectCompanyEvent event,
    Emitter<CreateCustomerState> emit,
  ) {
    emit(state.copyWith(selectedCompany: event.company));
  }

  void _onAddNewTag(AddNewTagEvent event, Emitter<CreateCustomerState> emit) {
    final tags = List<ContactTagModel>.from(state.selectedContactTags);
    if (!tags.any((e) => e.id == event.tag.id)) {
      tags.add(event.tag);
    }
    emit(state.copyWith(selectedContactTags: tags));
  }

  Future<void> _onRemoveSelectedTag(
    RemoveSelectedTagEvent event,
    Emitter<CreateCustomerState> emit,
  ) async {
    final updatedTags = List<ContactTagModel>.from(state.selectedContactTags);

    updatedTags.removeWhere((e) => e.id == event.tag.id);

    emit(state.copyWith(selectedContactTags: updatedTags));
  }

  Future<void> _createCustomer(
    CreateCustomerDataEvent event,
    Emitter<CreateCustomerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    try {
      final result = await createCustomerUseCase.call(data: event.data);
      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, errorMessage: failure.message));
        },
        (_) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
          customerBloc.add(FetchCustomerEvent(''));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onSelectCountry(
    SelectCountryEvent event,
    Emitter<CreateCustomerState> emit,
  ) async {
    emit(state.copyWith(selectedCountry: event.country));
    add(FetchStateEvent(event.country.id.toInt()));
  }

  Future<void> _onFetchState(
    FetchStateEvent event,
    Emitter<CreateCustomerState> emit,
  ) async {
    final result = await stateUseCase.call(countryId: event.countryId);
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (states) {
        emit(state.copyWith(isLoading: false, states: states));
      },
    );
  }

  void _onSelectState(
    SelectStateEvent event,
    Emitter<CreateCustomerState> emit,
  ) {
    emit(state.copyWith(selectedState: event.state));
  }

  void _onSelectPaymentTerms(
    SelectPaymentTermsEvent event,
    Emitter<CreateCustomerState> emit,
  ) {
    emit(
      state.copyWith(
        selectedPaymentTerms: event.paymentTerms,
        selectedPaymentTermsData: event.paymentTerms,
      ),
    );
  }

  void _addNote(AddNoteEvent event, Emitter<CreateCustomerState> emit) {
    emit(state.copyWith(note: event.note));
  }

  void _onChangeNoteType(
    ChangeNoteType event,
    Emitter<CreateCustomerState> emit,
  ) {
    emit(state.copyWith(selectedType: event.type));
  }

  void _onUpdateNoteText(
    UpdateNoteText event,
    Emitter<CreateCustomerState> emit,
  ) {
    emit(state.copyWith(noteText: event.text));
  }

  void _onStartRecording(
    StartRecording event,
    Emitter<CreateCustomerState> emit,
  ) {
    emit(state.copyWith(isRecording: true, recordingSeconds: 0));
    _startTimer();
  }

  void _onStopRecording(
    StopRecording event,
    Emitter<CreateCustomerState> emit,
  ) {
    _recordingTimer?.cancel();
    final duration = _formatDuration(state.recordingSeconds);
    emit(state.copyWith(isRecording: false, recordedDuration: duration));
  }

  void _onTickRecording(
    TickRecording event,
    Emitter<CreateCustomerState> emit,
  ) {
    emit(state.copyWith(recordingSeconds: state.recordingSeconds + 1));
  }

  void _onSelectFollowUpDate(
    SelectFollowUpDate event,
    Emitter<CreateCustomerState> emit,
  ) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onSaveNote(SaveNote event, Emitter<CreateCustomerState> emit) async {
    if (state.selectedNoteType.isText && state.noteText.trim().isEmpty) {
      ToastHelper.error(AppStringsConstants.noteErrorMsg);
      return;
    }

    if (state.selectedNoteType.isVoice &&
        state.recordedDuration.trim().isEmpty) {
      ToastHelper.error(AppStringsConstants.voiceNoteMsg);
      return;
    }

    if (state.selectedNoteType.isFollowUp && state.selectedNoteDate == null) {
      ToastHelper.error(AppStringsConstants.dateNoteMsg);
      return;
    }

    emit(state.copyWith(isSaving: true));

    final now = DateTime.now();
    final timeString = DateHelper.time(now.toIso8601String());

    Note newNote;

    if (state.selectedNoteType.isText) {
      newNote = Note(
        type: NoteType.text,
        title: AppStringsConstants.customer,
        time: '${AppStringsConstants.today}, $timeString',
        content: state.noteText.trim(),
        label: state.selectedNoteType.label,
        labelColor: AppColorsConstants.green,
      );
    } else if (state.selectedNoteType.isVoice) {
      newNote = Note(
        type: NoteType.voice,
        title: AppStringsConstants.customer,
        time: '${AppStringsConstants.today}, $timeString',
        content: '',
        label: state.selectedNoteType.label,
        labelColor: AppColorsConstants.blue,
        duration: state.recordedDuration,
      );
    } else {
      newNote = Note(
        type: NoteType.followup,
        title: AppStringsConstants.customer,
        time: '${AppStringsConstants.today}, $timeString',
        content: AppStringsConstants.followUpDate,
        label: state.selectedNoteType.label,
        labelColor: AppColorsConstants.orange,
        followUpDate: state.selectedNoteDate,
      );
    }

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    emit(state.copyWith(isSaving: false));
    event.onSuccess?.call(newNote);
  }

  void _startTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(TickRecording());
    });
  }

  String _formatDuration(int seconds) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  Future<void> close() {
    _recordingTimer?.cancel();
    return super.close();
  }
}
