// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_response.dart';

CommonResponse<T> _$CommonResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => CommonResponse<T>(
  success: json['success'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  status: json['status'] as String,
  message: json['message'] as String,
  data: fromJsonT(json['data']),
);

Map<String, dynamic> _$CommonResponseToJson<T>(
  CommonResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'status_code': instance.statusCode,
  'status': instance.status,
  'message': instance.message,
  'data': toJsonT(instance.data),
};
