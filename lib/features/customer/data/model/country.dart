import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryModel {
  final num id;

  final String name;

  final String code;

  @JsonKey(name: 'phone_code')
  final num phoneCode;

  @JsonKey(name: 'address_format')
  final String addressFormat;

  final CurrencyBean currency;

  CountryModel({
    required this.id,
    required this.name,
    required this.code,
    required this.phoneCode,
    required this.addressFormat,
    required this.currency,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}

@JsonSerializable()
class CurrencyBean {
  final num id;

  final String name;

  final String symbol;

  CurrencyBean({
    required this.id,
    required this.name,
    required this.symbol,
  });

  factory CurrencyBean.fromJson(Map<String, dynamic> json) =>
      _$CurrencyBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyBeanToJson(this);
}