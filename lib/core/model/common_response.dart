import 'package:json_annotation/json_annotation.dart';

part 'common_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CommonResponse<T> {
  final bool success;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String status;
  final String message;
  final T data;

  CommonResponse({
    required this.success,
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory CommonResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$CommonResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$CommonResponseToJson(this, toJsonT);
}
