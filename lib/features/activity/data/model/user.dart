import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final int id;
  final String name;
  final String login;
  final String email;
  final String phone;
  final String mobile;

  @JsonKey(name: 'company_id')
  final int companyId;

  final String company;
  final bool active;

  @JsonKey(name: 'profile_image')
  final String profileImage;

  const UserModel({
    required this.id,
    required this.name,
    required this.login,
    required this.email,
    required this.phone,
    required this.mobile,
    required this.companyId,
    required this.company,
    required this.active,
    required this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    login,
    email,
    phone,
    mobile,
    companyId,
    company,
    active,
    profileImage,
  ];
}