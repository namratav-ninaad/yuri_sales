// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) => InvoiceModel(
  id: (json['id'] as num).toInt(),
  invoiceNumber: json['invoice_number'] as String,
  invoiceDate: json['invoice_date'] as String,
  dueDate: json['due_date'] as String,
  state: json['state'] as String,
  customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
  company: CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
  currency: json['currency'] as String,
  untaxedAmount: (json['untaxed_amount'] as num).toDouble(),
  taxAmount: (json['tax_amount'] as num).toDouble(),
  totalAmount: (json['total_amount'] as num).toDouble(),
  paymentState: json['payment_state'] as String,
  lines: (json['lines'] as List<dynamic>)
      .map((e) => InvoiceLineModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_number': instance.invoiceNumber,
      'invoice_date': instance.invoiceDate,
      'due_date': instance.dueDate,
      'state': instance.state,
      'customer': instance.customer.toJson(),
      'company': instance.company.toJson(),
      'currency': instance.currency,
      'untaxed_amount': instance.untaxedAmount,
      'tax_amount': instance.taxAmount,
      'total_amount': instance.totalAmount,
      'payment_state': instance.paymentState,
      'lines': instance.lines.map((e) => e.toJson()).toList(),
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
);

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
};

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) =>
    CompanyModel(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

InvoiceLineModel _$InvoiceLineModelFromJson(Map<String, dynamic> json) =>
    InvoiceLineModel(
      productId: (json['product_id'] as num).toInt(),
      productName: json['product_name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$InvoiceLineModelToJson(InvoiceLineModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name': instance.productName,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'discount': instance.discount,
      'subtotal': instance.subtotal,
      'total': instance.total,
    };
