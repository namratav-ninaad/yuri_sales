import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(defaultValue: 0)
  num id;
  @JsonKey(defaultValue: '')
  String name;
  @JsonKey(defaultValue: '')
  String internal_reference;
  CategoryBean? category;
  CompanyBean? company;
  @JsonKey(defaultValue: 0)
  num list_price;
  @JsonKey(defaultValue: 0)
  num standard_price;
  @JsonKey(defaultValue: '')
  String image;
  @JsonKey(defaultValue: [])
  List<Sale_taxesBean> sale_taxes;
  @JsonKey(defaultValue: [])
  List<Purchase_taxesBean> purchase_taxes;
  @JsonKey(defaultValue: [])
  List<AttributesBean> attributes;
  @JsonKey(defaultValue: [])
  List<Warehouse_stockBean> warehouse_stock;
  @JsonKey(defaultValue: false)
  bool already_in_cart;

  ProductModel({
    required this.id,
    required this.name,
    required this.internal_reference,
    required this.category,
    required this.company,
    required this.list_price,
    required this.standard_price,
    required this.image,
    required this.sale_taxes,
    required this.purchase_taxes,
    required this.attributes,
    required this.warehouse_stock,
    this.already_in_cart = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class Warehouse_stockBean {
  num warehouse_id;
  String warehouse_name;
  num company_id;
  String company_name;
  num on_hand;
  num reserved_stock;
  num available_stock;
  num forecast_stock;

  Warehouse_stockBean({
    required this.warehouse_id,
    required this.warehouse_name,
    required this.company_id,
    required this.company_name,
    required this.on_hand,
    required this.reserved_stock,
    required this.available_stock,
    required this.forecast_stock,
  });

  factory Warehouse_stockBean.fromJson(Map<String, dynamic> json) =>
      _$Warehouse_stockBeanFromJson(json);

  Map<String, dynamic> toJson() => _$Warehouse_stockBeanToJson(this);
}

@JsonSerializable()
class AttributesBean {
  num attribute_id;
  String attribute_name;
  List<ValuesBean> values;

  AttributesBean({
    required this.attribute_id,
    required this.attribute_name,
    required this.values,
  });

  factory AttributesBean.fromJson(Map<String, dynamic> json) =>
      _$AttributesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesBeanToJson(this);
}

@JsonSerializable()
class ValuesBean {
  @JsonKey(defaultValue: 0)
  num id;
  @JsonKey(defaultValue: '')
  String name;

  ValuesBean({required this.id, required this.name});

  factory ValuesBean.fromJson(Map<String, dynamic> json) =>
      _$ValuesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ValuesBeanToJson(this);
}

@JsonSerializable()
class Purchase_taxesBean {
  num id;
  String name;
  num amount;

  Purchase_taxesBean({
    required this.id,
    required this.name,
    required this.amount,
  });

  factory Purchase_taxesBean.fromJson(Map<String, dynamic> json) =>
      _$Purchase_taxesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$Purchase_taxesBeanToJson(this);
}

@JsonSerializable()
class Sale_taxesBean {
  num id;
  String name;
  num amount;

  Sale_taxesBean({required this.id, required this.name, required this.amount});

  factory Sale_taxesBean.fromJson(Map<String, dynamic> json) =>
      _$Sale_taxesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$Sale_taxesBeanToJson(this);
}

@JsonSerializable()
class CompanyBean {
  @JsonKey(defaultValue: 0)
  num id;
  @JsonKey(defaultValue: '')
  String name;

  CompanyBean({required this.id, required this.name});

  factory CompanyBean.fromJson(Map<String, dynamic> json) =>
      _$CompanyBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyBeanToJson(this);
}

@JsonSerializable()
class CategoryBean {
  @JsonKey(defaultValue: 0)
  num id;
  @JsonKey(defaultValue: '')
  String name;

  CategoryBean({required this.id, required this.name});

  factory CategoryBean.fromJson(Map<String, dynamic> json) =>
      _$CategoryBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryBeanToJson(this);
}
