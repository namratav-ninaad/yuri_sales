// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      contactId: json['contact_id'] as num,
      fullName: json['full_name'] as String,
      companyId: json['company_id'] as num,
      companyName: json['company_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      mobile: json['mobile'] as String,
      quotationsCount: json['quotations_count'] as num,
      salesCount: json['sales_count'] as num,
      totalInvoice: json['total_invoice'] as num,
      deliveryCount: json['delivery_count'] as num,
      activityCount: json['activity_count'] as num,
      vat: json['vat'] as String,
      notes: json['notes'] as String,
      userId: json['user_id'] as num,
      userName: json['user_name'] as String,
      address: json['address'] as String,
      invoiceAddress: json['invoice_address'] as String,
      deliveryAddress: json['delivery_address'] as String,
      salePaymentTermId: json['sale_payment_term_id'] as num,
      salePaymentTermName: json['sale_payment_term_name'] as String,
      purchasePaymentTermId: json['purchase_payment_term_id'] as num,
      purchasePaymentTermName: json['purchase_payment_term_name'] as String,
      creditLimit: (json['credit_limit'] as num).toDouble(),
      tagIds: (json['tag_ids'] as List<dynamic>).map((e) => e as num).toList(),
      tagNames: (json['tag_names'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      image: json['image'] as String,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createDate: json['create_date'] as String,
      writeDate: json['write_date'] as String,
      customerStatement: json['customer_statement'] as num,
      commentCount: json['comment_count'] as num,
      emailCount: json['email_count'] as num,
      currencySymbol: json['currency_symbol'] as String,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'contact_id': instance.contactId,
      'full_name': instance.fullName,
      'company_id': instance.companyId,
      'company_name': instance.companyName,
      'email': instance.email,
      'phone': instance.phone,
      'mobile': instance.mobile,
      'quotations_count': instance.quotationsCount,
      'sales_count': instance.salesCount,
      'total_invoice': instance.totalInvoice,
      'customer_statement': instance.customerStatement,
      'currency_symbol': instance.currencySymbol,
      'delivery_count': instance.deliveryCount,
      'comment_count': instance.commentCount,
      'email_count': instance.emailCount,
      'activity_count': instance.activityCount,
      'vat': instance.vat,
      'notes': instance.notes,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'address': instance.address,
      'invoice_address': instance.invoiceAddress,
      'delivery_address': instance.deliveryAddress,
      'sale_payment_term_id': instance.salePaymentTermId,
      'sale_payment_term_name': instance.salePaymentTermName,
      'purchase_payment_term_id': instance.purchasePaymentTermId,
      'purchase_payment_term_name': instance.purchasePaymentTermName,
      'credit_limit': instance.creditLimit,
      'tag_ids': instance.tagIds,
      'tag_names': instance.tagNames,
      'image': instance.image,
      'attachments': instance.attachments,
      'create_date': instance.createDate,
      'write_date': instance.writeDate,
    };

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    AttachmentModel(
      id: json['id'] as num,
      name: json['name'] as String,
      mimetype: json['mimetype'] as String,
      fileSize: json['file_size'] as num,
      createDate: json['create_date'] as String,
      downloadUrl: json['download_url'] as String,
    );

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mimetype': instance.mimetype,
      'file_size': instance.fileSize,
      'create_date': instance.createDate,
      'download_url': instance.downloadUrl,
    };
