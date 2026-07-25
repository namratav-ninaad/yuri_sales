import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/features/customer/data/model/company_model.dart';
import 'package:yuri_sale/features/customer/data/model/contact_tag.dart';
import 'package:yuri_sale/features/customer/data/model/country.dart';
import 'package:yuri_sale/features/customer/data/model/note.dart';
import 'package:yuri_sale/features/customer/data/model/payment_terms.dart';
import 'package:yuri_sale/features/customer/data/model/state.dart';
import 'package:yuri_sale/features/customer/domain/entities/create_customer_data.dart';

abstract class CreateCustomerEvent {}

class ChangeNoteType extends CreateCustomerEvent {
  final NoteType type;

  ChangeNoteType({required this.type});
}

class UpdateNoteText extends CreateCustomerEvent {
  final String text;

  UpdateNoteText({required this.text});
}

class StartRecording extends CreateCustomerEvent {}

class StopRecording extends CreateCustomerEvent {}

class TickRecording extends CreateCustomerEvent {}

class SelectFollowUpDate extends CreateCustomerEvent {
  final DateTime date;

  SelectFollowUpDate({required this.date});
}

class SaveNote extends CreateCustomerEvent {
  final Function(Note note)? onSuccess;

  SaveNote({this.onSuccess});
}

class AddNoteEvent extends CreateCustomerEvent {
  final Note note;

  AddNoteEvent({required this.note});

  List<Object?> get props => [note];
}

class LoadCustomerDropDownDataEvent extends CreateCustomerEvent {}

class ResetCreateDataEvent extends CreateCustomerEvent {}

class FetchStateEvent extends CreateCustomerEvent {
  final int countryId;

  FetchStateEvent(this.countryId);

  List<Object?> get props => [countryId];
}

class SelectCountryEvent extends CreateCustomerEvent {
  final CountryModel country;

  SelectCountryEvent(this.country);

  List<Object?> get props => [country];
}

class SelectStateEvent extends CreateCustomerEvent {
  final StateModel state;

  SelectStateEvent(this.state);

  List<Object?> get props => [state];
}

class SelectCompanyEvent extends CreateCustomerEvent {
  final CompanyModel company;

  SelectCompanyEvent(this.company);

  List<Object?> get props => [company];
}

class AddNewTagEvent extends CreateCustomerEvent {
  final ContactTagModel tag;

  AddNewTagEvent({required this.tag});
}

class RemoveSelectedTagEvent extends CreateCustomerEvent {
  final ContactTagModel tag;

  RemoveSelectedTagEvent({required this.tag});
}

class SelectPaymentTermsEvent extends CreateCustomerEvent {
  final PaymentTermsModel paymentTerms;

  SelectPaymentTermsEvent(this.paymentTerms);

  List<Object?> get props => [paymentTerms];
}

class CreateCustomerDataEvent extends CreateCustomerEvent {
  final CreateCustomerData data;

  CreateCustomerDataEvent(this.data);

  List<Object?> get props => [data];
}

// Add these events
class AddAttachmentEvent extends CreateCustomerEvent {
  final AttachmentData attachment;

  AddAttachmentEvent(this.attachment);

  List<Object?> get props => [attachment];
}

class RemoveAttachmentEvent extends CreateCustomerEvent {
  final AttachmentData attachment;

  RemoveAttachmentEvent(this.attachment);

  List<Object?> get props => [attachment];
}

class SelectAddressTypeEvent extends CreateCustomerEvent {
  final AddressType addressType;

  SelectAddressTypeEvent(this.addressType);
}