import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderModel {
  final int id;

  @JsonKey(name: 'order_number')
  final String orderNumber;

  final Customer customer;

  final String status;

  @JsonKey(name: 'quotation_template')
  final String quotationTemplate;

  @JsonKey(name: 'payment_term')
  final String paymentTerm;

  @JsonKey(name: 'pricelist')
  final String priceList;

  final String salesperson;

  final String company;

  final String currency;

  @JsonKey(name: 'order_date')
  final String orderDate;

  @JsonKey(name: 'valid_until')
  final String validUntil;

  @JsonKey(name: 'invoice_status')
  final String invoiceStatus;

  @JsonKey(name: 'customer_reference')
  final String customerReference;

  @JsonKey(name: 'invoice_address')
  final AddressModel invoiceAddress;

  @JsonKey(name: 'delivery_address')
  final AddressModel deliveryAddress;

  @JsonKey(name: 'terms_and_conditions')
  final String termsAndConditions;

  @JsonKey(name: 'untaxed_amount')
  final double untaxedAmount;

  @JsonKey(name: 'tax_amount')
  final double taxAmount;

  @JsonKey(name: 'total_amount')
  final double totalAmount;

  @JsonKey(name: 'order_lines')
  final List<OrderLineModel> orderLines;

  @JsonKey(name: 'create_date')
  final String createDate;

  @JsonKey(name: 'write_date')
  final String writeDate;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.customer,
    required this.status,
    required this.quotationTemplate,
    required this.paymentTerm,
    required this.priceList,
    required this.salesperson,
    required this.company,
    required this.currency,
    required this.orderDate,
    required this.validUntil,
    required this.invoiceStatus,
    required this.customerReference,
    required this.invoiceAddress,
    required this.deliveryAddress,
    required this.termsAndConditions,
    required this.untaxedAmount,
    required this.taxAmount,
    required this.totalAmount,
    required this.orderLines,
    required this.createDate,
    required this.writeDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class Customer {
  final int id;
  final String name;

  Customer({required this.id, required this.name});

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

@JsonSerializable()
class AddressModel {
  final String name;
  final String street;
  final String street2;
  final String city;
  final String zip;
  final String state;
  final String country;

  AddressModel({
    required this.name,
    required this.street,
    required this.street2,
    required this.city,
    required this.zip,
    required this.state,
    required this.country,
  });

  /// Full address in one line
  String get fullAddress => [
    street,
    city,
    state,
    country,
    zip,
  ].where((e) => e.trim().isNotEmpty).join(' ');

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable()
class OrderLineModel {
  @JsonKey(name: 'line_id')
  final int lineId;

  @JsonKey(name: 'product_id')
  final int productId;

  @JsonKey(name: 'product_name')
  final String productName;

  @JsonKey(name: 'internal_reference')
  final String internalReference;

  final double quantity;

  final String uom;

  @JsonKey(name: 'unit_price')
  final double unitPrice;

  final double discount;

  final double subtotal;

  final double total;

  final List<TaxModel> taxes;

  final String image;

  OrderLineModel({
    required this.lineId,
    required this.productId,
    required this.productName,
    required this.internalReference,
    required this.quantity,
    required this.uom,
    required this.unitPrice,
    required this.discount,
    required this.subtotal,
    required this.total,
    required this.taxes,
    required this.image,
  });

  factory OrderLineModel.fromJson(Map<String, dynamic> json) =>
      _$OrderLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderLineModelToJson(this);
}

@JsonSerializable()
class TaxModel {
  final int id;
  final String name;
  final double amount;

  TaxModel({required this.id, required this.name, required this.amount});

  factory TaxModel.fromJson(Map<String, dynamic> json) =>
      _$TaxModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaxModelToJson(this);
}
