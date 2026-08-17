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
      createDate: json['create_date'] as String,
      writeDate: json['write_date'] as String,
    );

Map<String, dynamic> _$ContactTagModelToJson(ContactTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
      'create_date': instance.createDate,
      'write_date': instance.writeDate,
    };
