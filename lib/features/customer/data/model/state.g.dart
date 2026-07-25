// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateModel _$StateModelFromJson(Map<String, dynamic> json) => StateModel(
  id: json['id'] as num,
  name: json['name'] as String,
  code: json['code'] as String,
  country: CountryBean.fromJson(json['country'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StateModelToJson(StateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'country': instance.country,
    };

CountryBean _$CountryBeanFromJson(Map<String, dynamic> json) => CountryBean(
  id: json['id'] as num,
  name: json['name'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$CountryBeanToJson(CountryBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
