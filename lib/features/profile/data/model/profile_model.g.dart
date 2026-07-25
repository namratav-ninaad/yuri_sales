// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  user_id: json['user_id'] as num,
  full_name: json['full_name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  company: CompanyBean.fromJson(json['company'] as Map<String, dynamic>),
  device_type: json['device_type'] as String,
  profile_image: json['profile_image'] as String,
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'full_name': instance.full_name,
      'email': instance.email,
      'phone': instance.phone,
      'company': instance.company,
      'device_type': instance.device_type,
      'profile_image': instance.profile_image,
    };

CompanyBean _$CompanyBeanFromJson(Map<String, dynamic> json) =>
    CompanyBean(id: json['id'] as num, name: json['name'] as String);

Map<String, dynamic> _$CompanyBeanToJson(CompanyBean instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
