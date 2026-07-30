import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoiceModel extends Equatable {
  final int id;

  @JsonKey(name: 'invoice_number')
  final String invoiceNumber;

  @JsonKey(name: 'invoice_date')
  final String invoiceDate;

  @JsonKey(name: 'due_date')
  final String dueDate;

  final String state;

  final Customer customer;

  final CompanyModel company;

  final String currency;

  @JsonKey(name: 'untaxed_amount')
  final double untaxedAmount;

  @JsonKey(name: 'tax_amount')
  final double taxAmount;

  @JsonKey(name: 'total_amount')
  final double totalAmount;

  @JsonKey(name: 'payment_state')
  final String paymentState;

  final List<InvoiceLineModel> lines;

  const InvoiceModel({
    required this.id,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.dueDate,
    required this.state,
    required this.customer,
    required this.company,
    required this.currency,
    required this.untaxedAmount,
    required this.taxAmount,
    required this.totalAmount,
    required this.paymentState,
    required this.lines,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);

  InvoiceModel copyWith({
    int? id,
    String? invoiceNumber,
    String? invoiceDate,
    String? dueDate,
    String? state,
    Customer? customer,
    CompanyModel? company,
    String? currency,
    double? untaxedAmount,
    double? taxAmount,
    double? totalAmount,
    String? paymentState,
    List<InvoiceLineModel>? lines,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      dueDate: dueDate ?? this.dueDate,
      state: state ?? this.state,
      customer: customer ?? this.customer,
      company: company ?? this.company,
      currency: currency ?? this.currency,
      untaxedAmount: untaxedAmount ?? this.untaxedAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentState: paymentState ?? this.paymentState,
      lines: lines ?? this.lines,
    );
  }

  @override
  List<Object?> get props => [
    id,
    invoiceNumber,
    invoiceDate,
    dueDate,
    state,
    customer,
    company,
    currency,
    untaxedAmount,
    taxAmount,
    totalAmount,
    paymentState,
    lines,
  ];
}

@JsonSerializable()
class Customer extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;

  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
  ];
}

@JsonSerializable()
class CompanyModel extends Equatable {
  final int id;
  final String name;

  const CompanyModel({
    required this.id,
    required this.name,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
  ];
}

@JsonSerializable()
class InvoiceLineModel extends Equatable {
  @JsonKey(name: 'product_id')
  final int productId;

  @JsonKey(name: 'product_name')
  final String productName;

  final double quantity;

  @JsonKey(name: 'unit_price')
  final double unitPrice;

  final double discount;

  final double subtotal;

  final double total;

  const InvoiceLineModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.discount,
    required this.subtotal,
    required this.total,
  });

  factory InvoiceLineModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceLineModelToJson(this);

  @override
  List<Object?> get props => [
    productId,
    productName,
    quantity,
    unitPrice,
    discount,
    subtotal,
    total,
  ];
}