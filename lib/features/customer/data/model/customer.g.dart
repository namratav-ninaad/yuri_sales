// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      contact_id: json['contact_id'] as num,
      full_name: json['full_name'] as String,
      company_id: json['company_id'] as num,
      company_name: json['company_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      mobile: json['mobile'] as String,
      vat: json['vat'] as String,
      notes: json['notes'] as String,
      user_id: json['user_id'] as num,
      user_name: json['user_name'] as String,
      address: json['address'] as String,
      invoice_address: json['invoice_address'] as String,
      delivery_address: json['delivery_address'] as String,
      sale_payment_term_id: json['sale_payment_term_id'] as num,
      sale_payment_term_name: json['sale_payment_term_name'] as String,
      purchase_payment_term_id: json['purchase_payment_term_id'] as num,
      purchase_payment_term_name: json['purchase_payment_term_name'] as String,
      credit_limit: json['credit_limit'] as num,
      tag_ids: (json['tag_ids'] as List<dynamic>).map((e) => e as num).toList(),
      tag_names: (json['tag_names'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      image: json['image'] as String,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      create_date: json['create_date'] as String,
      write_date: json['write_date'] as String,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'contact_id': instance.contact_id,
      'full_name': instance.full_name,
      'company_id': instance.company_id,
      'company_name': instance.company_name,
      'email': instance.email,
      'phone': instance.phone,
      'mobile': instance.mobile,
      'vat': instance.vat,
      'notes': instance.notes,
      'user_id': instance.user_id,
      'user_name': instance.user_name,
      'address': instance.address,
      'invoice_address': instance.invoice_address,
      'delivery_address': instance.delivery_address,
      'sale_payment_term_id': instance.sale_payment_term_id,
      'sale_payment_term_name': instance.sale_payment_term_name,
      'purchase_payment_term_id': instance.purchase_payment_term_id,
      'purchase_payment_term_name': instance.purchase_payment_term_name,
      'credit_limit': instance.credit_limit,
      'tag_ids': instance.tag_ids,
      'tag_names': instance.tag_names,
      'image': instance.image,
      'attachments': instance.attachments,
      'create_date': instance.create_date,
      'write_date': instance.write_date,
    };

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    AttachmentModel(
      id: json['id'] as num,
      name: json['name'] as String,
      mimetype: json['mimetype'] as String,
      file_size: json['file_size'] as num,
      create_date: json['create_date'] as String,
      download_url: json['download_url'] as String,
    );

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mimetype': instance.mimetype,
      'file_size': instance.file_size,
      'create_date': instance.create_date,
      'download_url': instance.download_url,
    };
