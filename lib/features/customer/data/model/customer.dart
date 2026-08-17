import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class CustomerModel {
  @JsonKey(name: 'contact_id')
  final num contactId;

  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'company_id')
  final num companyId;

  @JsonKey(name: 'company_name')
  final String companyName;

  final String email;
  final String phone;
  final String mobile;

  @JsonKey(name: 'quotations_count')
  final num quotationsCount;

  @JsonKey(name: 'sales_count')
  final num salesCount;

  @JsonKey(name: 'total_invoice')
  final num totalInvoice;

  @JsonKey(name: 'customer_statement')
  final num customerStatement;

  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;

  @JsonKey(name: 'delivery_count')
  final num deliveryCount;

  @JsonKey(name: 'comment_count')
  final num commentCount;

  @JsonKey(name: 'email_count')
  final num emailCount;

  @JsonKey(name: 'activity_count')
  final num activityCount;

  final String vat;
  final String notes;

  @JsonKey(name: 'user_id')
  final num userId;

  @JsonKey(name: 'user_name')
  final String userName;

  final String address;

  @JsonKey(name: 'invoice_address')
  final String invoiceAddress;

  @JsonKey(name: 'delivery_address')
  final String deliveryAddress;

  @JsonKey(name: 'sale_payment_term_id')
  final num salePaymentTermId;

  @JsonKey(name: 'sale_payment_term_name')
  final String salePaymentTermName;

  @JsonKey(name: 'purchase_payment_term_id')
  final num purchasePaymentTermId;

  @JsonKey(name: 'purchase_payment_term_name')
  final String purchasePaymentTermName;

  @JsonKey(name: 'credit_limit')
  final double creditLimit;

  @JsonKey(name: 'tag_ids')
  final List<num> tagIds;

  @JsonKey(name: 'tag_names')
  final List<String> tagNames;

  final String image;

  final List<AttachmentModel> attachments;

  @JsonKey(name: 'create_date')
  final String createDate;

  @JsonKey(name: 'write_date')
  final String writeDate;

  const CustomerModel({
    required this.contactId,
    required this.fullName,
    required this.companyId,
    required this.companyName,
    required this.email,
    required this.phone,
    required this.mobile,
    required this.quotationsCount,
    required this.salesCount,
    required this.totalInvoice,
    required this.deliveryCount,
    required this.activityCount,
    required this.vat,
    required this.notes,
    required this.userId,
    required this.userName,
    required this.address,
    required this.invoiceAddress,
    required this.deliveryAddress,
    required this.salePaymentTermId,
    required this.salePaymentTermName,
    required this.purchasePaymentTermId,
    required this.purchasePaymentTermName,
    required this.creditLimit,
    required this.tagIds,
    required this.tagNames,
    required this.image,
    required this.attachments,
    required this.createDate,
    required this.writeDate,
    required this.customerStatement,
    required this.commentCount,
    required this.emailCount,
    required this.currencySymbol,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}

@JsonSerializable()
class AttachmentModel {
  final num id;
  final String name;
  final String mimetype;

  @JsonKey(name: 'file_size')
  final num fileSize;

  @JsonKey(name: 'create_date')
  final String createDate;

  @JsonKey(name: 'download_url')
  final String downloadUrl;

  const AttachmentModel({
    required this.id,
    required this.name,
    required this.mimetype,
    required this.fileSize,
    required this.createDate,
    required this.downloadUrl,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);
}
