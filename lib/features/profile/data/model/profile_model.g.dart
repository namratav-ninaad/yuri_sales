// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  userId: json['user_id'] as num,
  fullName: json['full_name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  company: CompanyBean.fromJson(json['company'] as Map<String, dynamic>),
  deviceType: json['device_type'] as String,
  profileImage: json['profile_image'] as String,
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'company': instance.company,
      'device_type': instance.deviceType,
      'profile_image': instance.profileImage,
    };

CompanyBean _$CompanyBeanFromJson(Map<String, dynamic> json) =>
    CompanyBean(id: json['id'] as num, name: json['name'] as String);

Map<String, dynamic> _$CompanyBeanToJson(CompanyBean instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
