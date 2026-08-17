// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
  id: json['id'] as num,
  name: json['name'] as String,
  code: json['code'] as String,
  phoneCode: json['phone_code'] as num,
  addressFormat: json['address_format'] as String,
  currency: CurrencyBean.fromJson(json['currency'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'phone_code': instance.phoneCode,
      'address_format': instance.addressFormat,
      'currency': instance.currency.toJson(),
    };

CurrencyBean _$CurrencyBeanFromJson(Map<String, dynamic> json) => CurrencyBean(
  id: json['id'] as num,
  name: json['name'] as String,
  symbol: json['symbol'] as String,
);

Map<String, dynamic> _$CurrencyBeanToJson(CurrencyBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
    };
