// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  internalReference: json['internal_reference'] as String,
  category: CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
  company: CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
  listPrice: (json['list_price'] as num).toDouble(),
  standardPrice: (json['standard_price'] as num).toDouble(),
  image: json['image'] as String,
  alreadyInCart: json['already_in_cart'] as bool,
  saleTaxes: (json['sale_taxes'] as List<dynamic>)
      .map((e) => TaxModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  purchaseTaxes: (json['purchase_taxes'] as List<dynamic>)
      .map((e) => TaxModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  attributes: (json['attributes'] as List<dynamic>)
      .map((e) => AttributeModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  currencyId: (json['currency_id'] as num).toInt(),
  currencyName: json['currency_name'] as String,
  currencySymbol: json['currency_symbol'] as String,
  totalStock: TotalStockModel.fromJson(
    json['total_stock'] as Map<String, dynamic>,
  ),
  warehouseStock: (json['warehouse_stock'] as List<dynamic>)
      .map((e) => WarehouseStockModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  createDate: json['create_date'] as String,
  writeDate: json['write_date'] as String,
);

Map<String, dynamic> _$ProductModelToJson(
  ProductModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'internal_reference': instance.internalReference,
  'category': instance.category.toJson(),
  'company': instance.company.toJson(),
  'list_price': instance.listPrice,
  'standard_price': instance.standardPrice,
  'image': instance.image,
  'already_in_cart': instance.alreadyInCart,
  'sale_taxes': instance.saleTaxes.map((e) => e.toJson()).toList(),
  'purchase_taxes': instance.purchaseTaxes.map((e) => e.toJson()).toList(),
  'attributes': instance.attributes.map((e) => e.toJson()).toList(),
  'currency_id': instance.currencyId,
  'currency_name': instance.currencyName,
  'currency_symbol': instance.currencySymbol,
  'total_stock': instance.totalStock.toJson(),
  'warehouse_stock': instance.warehouseStock.map((e) => e.toJson()).toList(),
  'create_date': instance.createDate,
  'write_date': instance.writeDate,
};

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
);

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

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

AttributeModel _$AttributeModelFromJson(Map<String, dynamic> json) =>
    AttributeModel(
      attributeId: (json['attribute_id'] as num).toInt(),
      attributeName: json['attribute_name'] as String,
      values: (json['values'] as List<dynamic>)
          .map((e) => AttributeValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttributeModelToJson(AttributeModel instance) =>
    <String, dynamic>{
      'attribute_id': instance.attributeId,
      'attribute_name': instance.attributeName,
      'values': instance.values.map((e) => e.toJson()).toList(),
    };

AttributeValueModel _$AttributeValueModelFromJson(Map<String, dynamic> json) =>
    AttributeValueModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$AttributeValueModelToJson(
  AttributeValueModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

TotalStockModel _$TotalStockModelFromJson(Map<String, dynamic> json) =>
    TotalStockModel(
      onHand: (json['on_hand'] as num).toDouble(),
      reservedStock: (json['reserved_stock'] as num).toDouble(),
      availableStock: (json['available_stock'] as num).toDouble(),
      forecastStock: (json['forecast_stock'] as num).toDouble(),
      isInStock: json['is_in_stock'] as bool,
      isOutOfStock: json['is_out_of_stock'] as bool,
    );

Map<String, dynamic> _$TotalStockModelToJson(TotalStockModel instance) =>
    <String, dynamic>{
      'on_hand': instance.onHand,
      'reserved_stock': instance.reservedStock,
      'available_stock': instance.availableStock,
      'forecast_stock': instance.forecastStock,
      'is_in_stock': instance.isInStock,
      'is_out_of_stock': instance.isOutOfStock,
    };

WarehouseStockModel _$WarehouseStockModelFromJson(Map<String, dynamic> json) =>
    WarehouseStockModel(
      warehouseId: (json['warehouse_id'] as num).toInt(),
      warehouseName: json['warehouse_name'] as String,
      companyId: (json['company_id'] as num).toInt(),
      companyName: json['company_name'] as String,
      onHand: (json['on_hand'] as num).toDouble(),
      reservedStock: (json['reserved_stock'] as num).toDouble(),
      availableStock: (json['available_stock'] as num).toDouble(),
      forecastStock: (json['forecast_stock'] as num).toDouble(),
    );

Map<String, dynamic> _$WarehouseStockModelToJson(
  WarehouseStockModel instance,
) => <String, dynamic>{
  'warehouse_id': instance.warehouseId,
  'warehouse_name': instance.warehouseName,
  'company_id': instance.companyId,
  'company_name': instance.companyName,
  'on_hand': instance.onHand,
  'reserved_stock': instance.reservedStock,
  'available_stock': instance.availableStock,
  'forecast_stock': instance.forecastStock,
};
