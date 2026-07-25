// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactTagModel _$ContactTagModelFromJson(Map<String, dynamic> json) =>
    ContactTagModel(
      id: json['id'] as num,
      name: json['name'] as String,
      active: json['active'] as bool,
      create_date: json['create_date'] as String,
      write_date: json['write_date'] as String,
    );

Map<String, dynamic> _$ContactTagModelToJson(ContactTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
      'create_date': instance.create_date,
      'write_date': instance.write_date,
    };
