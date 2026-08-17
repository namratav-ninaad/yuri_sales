import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel {
  final int id;
  final String name;

  @JsonKey(name: 'internal_reference')
  final String internalReference;

  final CategoryModel category;
  final CompanyModel company;

  @JsonKey(name: 'list_price')
  final double listPrice;

  @JsonKey(name: 'standard_price')
  final double standardPrice;

  final String image;

  @JsonKey(name: 'already_in_cart')
  bool alreadyInCart;

  @JsonKey(name: 'sale_taxes')
  final List<TaxModel> saleTaxes;

  @JsonKey(name: 'purchase_taxes')
  final List<TaxModel> purchaseTaxes;

  final List<AttributeModel> attributes;

  @JsonKey(name: 'currency_id')
  final int currencyId;

  @JsonKey(name: 'currency_name')
  final String currencyName;

  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;

  @JsonKey(name: 'total_stock')
  final TotalStockModel totalStock;

  @JsonKey(name: 'warehouse_stock')
  final List<WarehouseStockModel> warehouseStock;

  @JsonKey(name: 'create_date')
  final String createDate;

  @JsonKey(name: 'write_date')
  final String writeDate;

  ProductModel({
    required this.id,
    required this.name,
    required this.internalReference,
    required this.category,
    required this.company,
    required this.listPrice,
    required this.standardPrice,
    required this.image,
    required this.alreadyInCart,
    required this.saleTaxes,
    required this.purchaseTaxes,
    required this.attributes,
    required this.currencyId,
    required this.currencyName,
    required this.currencySymbol,
    required this.totalStock,
    required this.warehouseStock,
    required this.createDate,
    required this.writeDate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class CategoryModel {
  final int id;
  final String name;

  const CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class CompanyModel {
  final int? id;
  final String? name;

  const CompanyModel({this.id, this.name});

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}

@JsonSerializable()
class TaxModel {
  final int id;
  final String name;
  final double amount;

  const TaxModel({required this.id, required this.name, required this.amount});

  factory TaxModel.fromJson(Map<String, dynamic> json) =>
      _$TaxModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaxModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AttributeModel {
  @JsonKey(name: 'attribute_id')
  final int attributeId;

  @JsonKey(name: 'attribute_name')
  final String attributeName;

  final List<AttributeValueModel> values;

  const AttributeModel({
    required this.attributeId,
    required this.attributeName,
    required this.values,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeModelToJson(this);
}

@JsonSerializable()
class AttributeValueModel {
  final int id;
  final String name;

  const AttributeValueModel({required this.id, required this.name});

  factory AttributeValueModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeValueModelToJson(this);
}

@JsonSerializable()
class TotalStockModel {
  @JsonKey(name: 'on_hand')
  final double onHand;

  @JsonKey(name: 'reserved_stock')
  final double reservedStock;

  @JsonKey(name: 'available_stock')
  final double availableStock;

  @JsonKey(name: 'forecast_stock')
  final double forecastStock;

  @JsonKey(name: 'is_in_stock')
  final bool isInStock;

  @JsonKey(name: 'is_out_of_stock')
  final bool isOutOfStock;

  const TotalStockModel({
    required this.onHand,
    required this.reservedStock,
    required this.availableStock,
    required this.forecastStock,
    required this.isInStock,
    required this.isOutOfStock,
  });

  factory TotalStockModel.fromJson(Map<String, dynamic> json) =>
      _$TotalStockModelFromJson(json);

  Map<String, dynamic> toJson() => _$TotalStockModelToJson(this);
}

@JsonSerializable()
class WarehouseStockModel {
  @JsonKey(name: 'warehouse_id')
  final int warehouseId;

  @JsonKey(name: 'warehouse_name')
  final String warehouseName;

  @JsonKey(name: 'company_id')
  final int companyId;

  @JsonKey(name: 'company_name')
  final String companyName;

  @JsonKey(name: 'on_hand')
  final double onHand;

  @JsonKey(name: 'reserved_stock')
  final double reservedStock;

  @JsonKey(name: 'available_stock')
  final double availableStock;

  @JsonKey(name: 'forecast_stock')
  final double forecastStock;

  const WarehouseStockModel({
    required this.warehouseId,
    required this.warehouseName,
    required this.companyId,
    required this.companyName,
    required this.onHand,
    required this.reservedStock,
    required this.availableStock,
    required this.forecastStock,
  });

  factory WarehouseStockModel.fromJson(Map<String, dynamic> json) =>
      _$WarehouseStockModelFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseStockModelToJson(this);
}
