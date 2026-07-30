import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery.g.dart';

@JsonSerializable(explicitToJson: true)
class DeliveryModel extends Equatable {
  @JsonKey(name: 'delivery_id')
  final int deliveryId;

  @JsonKey(name: 'delivery_name')
  final String deliveryName;

  @JsonKey(name: 'sale_order_id')
  final int saleOrderId;

  @JsonKey(name: 'sale_order_name')
  final String saleOrderName;

  @JsonKey(name: 'partner_id')
  final int partnerId;

  @JsonKey(name: 'partner_name')
  final String partnerName;

  final String origin;
  final String state;

  @JsonKey(name: 'scheduled_date')
  final String scheduledDate;

  @JsonKey(name: 'done_date')
  final String doneDate;

  @JsonKey(name: 'operation_type_id')
  final int operationTypeId;

  @JsonKey(name: 'operation_type')
  final String operationType;

  @JsonKey(name: 'source_location')
  final String sourceLocation;

  @JsonKey(name: 'destination_location')
  final String destinationLocation;

  final String carrier;

  @JsonKey(name: 'tracking_reference')
  final String trackingReference;

  final List<DeliveryProductModel> products;

  @JsonKey(name: 'create_date')
  final String createDate;

  @JsonKey(name: 'write_date')
  final String writeDate;

  const DeliveryModel({
    required this.deliveryId,
    required this.deliveryName,
    required this.saleOrderId,
    required this.saleOrderName,
    required this.partnerId,
    required this.partnerName,
    required this.origin,
    required this.state,
    required this.scheduledDate,
    required this.doneDate,
    required this.operationTypeId,
    required this.operationType,
    required this.sourceLocation,
    required this.destinationLocation,
    required this.carrier,
    required this.trackingReference,
    required this.products,
    required this.createDate,
    required this.writeDate,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryModelToJson(this);

  @override
  List<Object?> get props => [
    deliveryId,
    deliveryName,
    saleOrderId,
    saleOrderName,
    partnerId,
    partnerName,
    origin,
    state,
    scheduledDate,
    doneDate,
    operationTypeId,
    operationType,
    sourceLocation,
    destinationLocation,
    carrier,
    trackingReference,
    products,
    createDate,
    writeDate,
  ];
}

@JsonSerializable()
class DeliveryProductModel extends Equatable {
  @JsonKey(name: 'product_id')
  final int productId;

  @JsonKey(name: 'product_name')
  final String productName;

  @JsonKey(name: 'ordered_qty')
  final double orderedQty;

  @JsonKey(name: 'delivered_qty')
  final double deliveredQty;

  final String uom;

  const DeliveryProductModel({
    required this.productId,
    required this.productName,
    required this.orderedQty,
    required this.deliveredQty,
    required this.uom,
  });

  factory DeliveryProductModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryProductModelToJson(this);

  @override
  List<Object?> get props => [
    productId,
    productName,
    orderedQty,
    deliveredQty,
    uom,
  ];
}