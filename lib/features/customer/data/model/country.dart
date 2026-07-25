import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class CountryModel {
  num id;
  String name;
  String code;
  num phone_code;
  String address_format;
  CurrencyBean currency;

  CountryModel({
    required this.id,
    required this.name,
    required this.code,
    required this.phone_code,
    required this.address_format,
    required this.currency,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}

@JsonSerializable()
class CurrencyBean {
  num id;
  String name;
  String symbol;

  CurrencyBean({required this.id, required this.name, required this.symbol});

  factory CurrencyBean.fromJson(Map<String, dynamic> json) =>
      _$CurrencyBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyBeanToJson(this);
}
