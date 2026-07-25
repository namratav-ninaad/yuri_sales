import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class CustomerModel {
  num contact_id;
  String full_name;
  num company_id;
  String company_name;
  String email;
  String phone;
  String mobile;
  String vat;
  String notes;
  num user_id;
  String user_name;
  String address;
  String invoice_address;
  String delivery_address;
  num sale_payment_term_id;
  String sale_payment_term_name;
  num purchase_payment_term_id;
  String purchase_payment_term_name;
  num credit_limit;
  List<num> tag_ids;
  List<String> tag_names;
  String image;
  List<AttachmentModel> attachments;
  String create_date;
  String write_date;

  CustomerModel({
    required this.contact_id,
    required this.full_name,
    required this.company_id,
    required this.company_name,
    required this.email,
    required this.phone,
    required this.mobile,
    required this.vat,
    required this.notes,
    required this.user_id,
    required this.user_name,
    required this.address,
    required this.invoice_address,
    required this.delivery_address,
    required this.sale_payment_term_id,
    required this.sale_payment_term_name,
    required this.purchase_payment_term_id,
    required this.purchase_payment_term_name,
    required this.credit_limit,
    required this.tag_ids,
    required this.tag_names,
    required this.image,
    required this.attachments,
    required this.create_date,
    required this.write_date,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}

@JsonSerializable()
class AttachmentModel {
  num id;
  String name;
  String mimetype;
  num file_size;
  String create_date;
  String download_url;

  AttachmentModel({
    required this.id,
    required this.name,
    required this.mimetype,
    required this.file_size,
    required this.create_date,
    required this.download_url,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);
}
