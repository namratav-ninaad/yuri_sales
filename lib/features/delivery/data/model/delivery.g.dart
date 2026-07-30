// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryModel _$DeliveryModelFromJson(Map<String, dynamic> json) =>
    DeliveryModel(
      deliveryId: (json['delivery_id'] as num).toInt(),
      deliveryName: json['delivery_name'] as String,
      saleOrderId: (json['sale_order_id'] as num).toInt(),
      saleOrderName: json['sale_order_name'] as String,
      partnerId: (json['partner_id'] as num).toInt(),
      partnerName: json['partner_name'] as String,
      origin: json['origin'] as String,
      state: json['state'] as String,
      scheduledDate: json['scheduled_date'] as String,
      doneDate: json['done_date'] as String,
      operationTypeId: (json['operation_type_id'] as num).toInt(),
      operationType: json['operation_type'] as String,
      sourceLocation: json['source_location'] as String,
      destinationLocation: json['destination_location'] as String,
      carrier: json['carrier'] as String,
      trackingReference: json['tracking_reference'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => DeliveryProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createDate: json['create_date'] as String,
      writeDate: json['write_date'] as String,
    );

Map<String, dynamic> _$DeliveryModelToJson(DeliveryModel instance) =>
    <String, dynamic>{
      'delivery_id': instance.deliveryId,
      'delivery_name': instance.deliveryName,
      'sale_order_id': instance.saleOrderId,
      'sale_order_name': instance.saleOrderName,
      'partner_id': instance.partnerId,
      'partner_name': instance.partnerName,
      'origin': instance.origin,
      'state': instance.state,
      'scheduled_date': instance.scheduledDate,
      'done_date': instance.doneDate,
      'operation_type_id': instance.operationTypeId,
      'operation_type': instance.operationType,
      'source_location': instance.sourceLocation,
      'destination_location': instance.destinationLocation,
      'carrier': instance.carrier,
      'tracking_reference': instance.trackingReference,
      'products': instance.products.map((e) => e.toJson()).toList(),
      'create_date': instance.createDate,
      'write_date': instance.writeDate,
    };

DeliveryProductModel _$DeliveryProductModelFromJson(
  Map<String, dynamic> json,
) => DeliveryProductModel(
  productId: (json['product_id'] as num).toInt(),
  productName: json['product_name'] as String,
  orderedQty: (json['ordered_qty'] as num).toDouble(),
  deliveredQty: (json['delivered_qty'] as num).toDouble(),
  uom: json['uom'] as String,
);

Map<String, dynamic> _$DeliveryProductModelToJson(
  DeliveryProductModel instance,
) => <String, dynamic>{
  'product_id': instance.productId,
  'product_name': instance.productName,
  'ordered_qty': instance.orderedQty,
  'delivered_qty': instance.deliveredQty,
  'uom': instance.uom,
};
