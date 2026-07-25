// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
  userId: (json['user_id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  companyId: (json['company_id'] as num).toInt(),
  companyName: json['company_name'] as String,
  userType: json['user_type'] as String,
  deviceType: json['device_type'] as String,
  accessToken: json['access_token'] as String,
  sessionId: json['session_id'] as String,
);

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'company_id': instance.companyId,
      'company_name': instance.companyName,
      'user_type': instance.userType,
      'device_type': instance.deviceType,
      'access_token': instance.accessToken,
      'session_id': instance.sessionId,
    };
