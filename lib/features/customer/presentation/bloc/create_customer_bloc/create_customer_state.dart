import 'package:equatable/equatable.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/features/customer/data/model/company.dart';
import 'package:yuri_sale/features/customer/data/model/contact_tag.dart';
import 'package:yuri_sale/features/customer/data/model/country.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart';
import 'package:yuri_sale/features/customer/data/model/note.dart';
import 'package:yuri_sale/features/customer/data/model/payment_terms.dart';
import 'package:yuri_sale/features/customer/data/model/state.dart';
import 'package:yuri_sale/features/customer/domain/entities/create_customer_data.dart';

class CreateCustomerState extends Equatable {
  final NoteType selectedNoteType;
  final String noteText;
  final bool isRecording;
  final int recordingSeconds;
  final String recordedDuration;
  final DateTime? selectedNoteDate;
  final bool isSaving;
  final Note? note;
  final bool isLoading;
  final List<CustomerModel> customers;
  final String? errorMessage;
  final String searchQuery;
  final bool isSuccess;
  final List<CompanyModel> companies;
  final CompanyModel? selectedCompany;
  final List<PaymentTermsModel> paymentTerms;
  final PaymentTermsModel? selectedPaymentTerms;
  final PaymentTermsModel? selectedPaymentTermsData;
  final List<ContactTagModel> contactTags;
  final List<ContactTagModel> selectedContactTags;
  final List<AttachmentData> attachments;
  final List<CountryModel> countries;
  final CountryModel? selectedCountry;
  final List<StateModel> states;
  final StateModel? selectedState;
  final AddressType selectedAddressType;

  const CreateCustomerState({
    this.selectedNoteType = NoteType.text,
    this.noteText = '',
    this.isRecording = false,
    this.recordingSeconds = 0,
    this.recordedDuration = '',
    this.selectedNoteDate,
    this.isSaving = false,
    this.selectedContactTags = const [],
    this.companies = const [],
    this.selectedCompany,
    this.note,
    this.isLoading = false,
    this.isSuccess = false,
    this.customers = const [],
    this.errorMessage,
    this.searchQuery = '',
    this.paymentTerms = const [],
    this.selectedPaymentTerms,
    this.contactTags = const [],
    this.attachments = const [],
    this.selectedPaymentTermsData,
    this.countries = const [],
    this.states = const [],
    this.selectedCountry,
    this.selectedAddressType = AddressType.gpsLocation,
    this.selectedState,
  });

  CreateCustomerState copyWith({
    NoteType? selectedType,
    String? noteText,
    bool? isRecording,
    Note? note,
    bool? isSuccess,
    int? recordingSeconds,
    String? recordedDuration,
    DateTime? selectedNoteDate,
    bool? isSaving,
    List<ContactTagModel>? selectedContactTags,
    bool? isLoading,
    List<CustomerModel>? customers,
    List<CompanyModel>? companies,
    CompanyModel? selectedCompany,
    List<ContactTagModel>? contactTags,
    List<PaymentTermsModel>? paymentTerms,
    PaymentTermsModel? selectedPaymentTerms,
    String? errorMessage,
    String? searchQuery,
    List<AttachmentData>? attachments,
    PaymentTermsModel? selectedPaymentTermsData,
    List<CountryModel>? countries,
    List<StateModel>? states,
    CountryModel? selectedCountry,
    StateModel? selectedState,
    AddressType? selectedAddressType,
    bool clearSelectedCountry = false,
    bool clearSelectedState = false,
  }) {
    return CreateCustomerState(
      contactTags: contactTags ?? this.contactTags,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      selectedPaymentTerms: selectedPaymentTerms ?? this.selectedPaymentTerms,
      searchQuery: searchQuery ?? this.searchQuery,
      companies: companies ?? this.companies,
      selectedCompany: selectedCompany ?? this.selectedCompany,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      customers: customers ?? this.customers,
      selectedNoteType: selectedType ?? selectedNoteType,
      noteText: noteText ?? this.noteText,
      note: note ?? this.note,
      isRecording: isRecording ?? this.isRecording,
      recordingSeconds: recordingSeconds ?? this.recordingSeconds,
      recordedDuration: recordedDuration ?? this.recordedDuration,
      selectedNoteDate: selectedNoteDate ?? selectedNoteDate,
      isSaving: isSaving ?? this.isSaving,
      selectedContactTags: selectedContactTags ?? this.selectedContactTags,
      attachments: attachments ?? this.attachments,
      selectedPaymentTermsData:
          selectedPaymentTermsData ?? this.selectedPaymentTermsData,
      countries: countries ?? this.countries,
      states: states ?? this.states,
      selectedCountry: clearSelectedCountry
          ? null
          : (selectedCountry ?? this.selectedCountry),

      selectedState: clearSelectedState
          ? null
          : (selectedState ?? this.selectedState),

      selectedAddressType: selectedAddressType ?? this.selectedAddressType,
    );
  }

  @override
  List<Object?> get props => [
    states,
    countries,
    selectedCountry,
    selectedState,
    attachments,
    contactTags,
    companies,
    selectedCompany,
    errorMessage,
    isLoading,
    customers,
    selectedNoteType,
    selectedAddressType,
    noteText,
    isRecording,
    recordingSeconds,
    recordedDuration,
    selectedNoteDate,
    isSaving,
    selectedContactTags,
    selectedPaymentTermsData,
    note,
  ];
}
