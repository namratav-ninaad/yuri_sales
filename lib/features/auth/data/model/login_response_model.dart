import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginModel {
  @JsonKey(name: 'user_id')
  final int userId;
  final String name;
  final String email;
  final String phone;
  @JsonKey(name: 'company_id')
  final int companyId;

  @JsonKey(name: 'company_name')
  final String companyName;

  @JsonKey(name: 'user_type')
  final String userType;

  @JsonKey(name: 'device_type')
  final String deviceType;

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'session_id')
  final String sessionId;

  LoginModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.companyId,
    required this.companyName,
    required this.userType,
    required this.deviceType,
    required this.accessToken,
    required this.sessionId,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
