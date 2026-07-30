// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: (json['id'] as num).toInt(),
  orderNumber: json['order_number'] as String,
  customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
  status: json['status'] as String,
  quotationTemplate: json['quotation_template'] as String,
  paymentTerm: json['payment_term'] as String,
  priceList: json['pricelist'] as String,
  salesperson: json['salesperson'] as String,
  company: json['company'] as String,
  currency: json['currency'] as String,
  orderDate: json['order_date'] as String,
  validUntil: json['valid_until'] as String,
  invoiceStatus: json['invoice_status'] as String,
  customerReference: json['customer_reference'] as String,
  invoiceAddress: AddressModel.fromJson(
    json['invoice_address'] as Map<String, dynamic>,
  ),
  deliveryAddress: AddressModel.fromJson(
    json['delivery_address'] as Map<String, dynamic>,
  ),
  termsAndConditions: json['terms_and_conditions'] as String,
  untaxedAmount: (json['untaxed_amount'] as num).toDouble(),
  taxAmount: (json['tax_amount'] as num).toDouble(),
  totalAmount: (json['total_amount'] as num).toDouble(),
  orderLines: (json['order_lines'] as List<dynamic>)
      .map((e) => OrderLineModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  createDate: json['create_date'] as String,
  writeDate: json['write_date'] as String,
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'customer': instance.customer,
      'status': instance.status,
      'quotation_template': instance.quotationTemplate,
      'payment_term': instance.paymentTerm,
      'pricelist': instance.priceList,
      'salesperson': instance.salesperson,
      'company': instance.company,
      'currency': instance.currency,
      'order_date': instance.orderDate,
      'valid_until': instance.validUntil,
      'invoice_status': instance.invoiceStatus,
      'customer_reference': instance.customerReference,
      'invoice_address': instance.invoiceAddress,
      'delivery_address': instance.deliveryAddress,
      'terms_and_conditions': instance.termsAndConditions,
      'untaxed_amount': instance.untaxedAmount,
      'tax_amount': instance.taxAmount,
      'total_amount': instance.totalAmount,
      'order_lines': instance.orderLines,
      'create_date': instance.createDate,
      'write_date': instance.writeDate,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) =>
    Customer(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
  name: json['name'] as String,
  street: json['street'] as String,
  street2: json['street2'] as String,
  city: json['city'] as String,
  zip: json['zip'] as String,
  state: json['state'] as String,
  country: json['country'] as String,
);

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'street': instance.street,
      'street2': instance.street2,
      'city': instance.city,
      'zip': instance.zip,
      'state': instance.state,
      'country': instance.country,
    };

OrderLineModel _$OrderLineModelFromJson(Map<String, dynamic> json) =>
    OrderLineModel(
      lineId: (json['line_id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      productName: json['product_name'] as String,
      internalReference: json['internal_reference'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      uom: json['uom'] as String,
      unitPrice: (json['unit_price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      taxes: (json['taxes'] as List<dynamic>)
          .map((e) => TaxModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String,
    );

Map<String, dynamic> _$OrderLineModelToJson(OrderLineModel instance) =>
    <String, dynamic>{
      'line_id': instance.lineId,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'internal_reference': instance.internalReference,
      'quantity': instance.quantity,
      'uom': instance.uom,
      'unit_price': instance.unitPrice,
      'discount': instance.discount,
      'subtotal': instance.subtotal,
      'total': instance.total,
      'taxes': instance.taxes,
      'image': instance.image,
    };

TaxModel _$TaxModelFromJson(Map<String, dynamic> json) => TaxModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  amount: (json['amount'] as num).toDouble(),
);

Map<String, dynamic> _$TaxModelToJson(TaxModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'amount': instance.amount,
};
