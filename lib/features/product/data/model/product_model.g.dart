// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: json['id'] as num? ?? 0,
  name: json['name'] as String? ?? '',
  internal_reference: json['internal_reference'] as String? ?? '',
  category: json['category'] == null
      ? null
      : CategoryBean.fromJson(json['category'] as Map<String, dynamic>),
  company: json['company'] == null
      ? null
      : CompanyBean.fromJson(json['company'] as Map<String, dynamic>),
  list_price: json['list_price'] as num? ?? 0,
  standard_price: json['standard_price'] as num? ?? 0,
  image: json['image'] as String? ?? '',
  sale_taxes:
      (json['sale_taxes'] as List<dynamic>?)
          ?.map((e) => Sale_taxesBean.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  purchase_taxes:
      (json['purchase_taxes'] as List<dynamic>?)
          ?.map((e) => Purchase_taxesBean.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  attributes:
      (json['attributes'] as List<dynamic>?)
          ?.map((e) => AttributesBean.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  warehouse_stock:
      (json['warehouse_stock'] as List<dynamic>?)
          ?.map((e) => Warehouse_stockBean.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  already_in_cart: json['already_in_cart'] as bool? ?? false,
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'internal_reference': instance.internal_reference,
      'category': instance.category,
      'company': instance.company,
      'list_price': instance.list_price,
      'standard_price': instance.standard_price,
      'image': instance.image,
      'sale_taxes': instance.sale_taxes,
      'purchase_taxes': instance.purchase_taxes,
      'attributes': instance.attributes,
      'warehouse_stock': instance.warehouse_stock,
      'already_in_cart': instance.already_in_cart,
    };

Warehouse_stockBean _$Warehouse_stockBeanFromJson(Map<String, dynamic> json) =>
    Warehouse_stockBean(
      warehouse_id: json['warehouse_id'] as num,
      warehouse_name: json['warehouse_name'] as String,
      company_id: json['company_id'] as num,
      company_name: json['company_name'] as String,
      on_hand: json['on_hand'] as num,
      reserved_stock: json['reserved_stock'] as num,
      available_stock: json['available_stock'] as num,
      forecast_stock: json['forecast_stock'] as num,
    );

Map<String, dynamic> _$Warehouse_stockBeanToJson(
  Warehouse_stockBean instance,
) => <String, dynamic>{
  'warehouse_id': instance.warehouse_id,
  'warehouse_name': instance.warehouse_name,
  'company_id': instance.company_id,
  'company_name': instance.company_name,
  'on_hand': instance.on_hand,
  'reserved_stock': instance.reserved_stock,
  'available_stock': instance.available_stock,
  'forecast_stock': instance.forecast_stock,
};

AttributesBean _$AttributesBeanFromJson(Map<String, dynamic> json) =>
    AttributesBean(
      attribute_id: json['attribute_id'] as num,
      attribute_name: json['attribute_name'] as String,
      values: (json['values'] as List<dynamic>)
          .map((e) => ValuesBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttributesBeanToJson(AttributesBean instance) =>
    <String, dynamic>{
      'attribute_id': instance.attribute_id,
      'attribute_name': instance.attribute_name,
      'values': instance.values,
    };

ValuesBean _$ValuesBeanFromJson(Map<String, dynamic> json) => ValuesBean(
  id: json['id'] as num? ?? 0,
  name: json['name'] as String? ?? '',
);

Map<String, dynamic> _$ValuesBeanToJson(ValuesBean instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

Purchase_taxesBean _$Purchase_taxesBeanFromJson(Map<String, dynamic> json) =>
    Purchase_taxesBean(
      id: json['id'] as num,
      name: json['name'] as String,
      amount: json['amount'] as num,
    );

Map<String, dynamic> _$Purchase_taxesBeanToJson(Purchase_taxesBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
    };

Sale_taxesBean _$Sale_taxesBeanFromJson(Map<String, dynamic> json) =>
    Sale_taxesBean(
      id: json['id'] as num,
      name: json['name'] as String,
      amount: json['amount'] as num,
    );

Map<String, dynamic> _$Sale_taxesBeanToJson(Sale_taxesBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
    };

CompanyBean _$CompanyBeanFromJson(Map<String, dynamic> json) => CompanyBean(
  id: json['id'] as num? ?? 0,
  name: json['name'] as String? ?? '',
);

Map<String, dynamic> _$CompanyBeanToJson(CompanyBean instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

CategoryBean _$CategoryBeanFromJson(Map<String, dynamic> json) => CategoryBean(
  id: json['id'] as num? ?? 0,
  name: json['name'] as String? ?? '',
);

Map<String, dynamic> _$CategoryBeanToJson(CategoryBean instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
