// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  login: json['login'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  mobile: json['mobile'] as String,
  companyId: (json['company_id'] as num).toInt(),
  company: json['company'] as String,
  active: json['active'] as bool,
  profileImage: json['profile_image'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'login': instance.login,
  'email': instance.email,
  'phone': instance.phone,
  'mobile': instance.mobile,
  'company_id': instance.companyId,
  'company': instance.company,
  'active': instance.active,
  'profile_image': instance.profileImage,
};
