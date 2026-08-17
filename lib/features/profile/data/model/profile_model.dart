import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {

  @JsonKey(name: 'user_id')
  num userId;
  @JsonKey(name: 'full_name')
  String fullName;
  String email;
  String phone;
  CompanyBean company;
  @JsonKey(name: 'device_type')
  String deviceType;
  @JsonKey(name: 'profile_image')
  String profileImage;

  ProfileModel({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.company,
    required this.deviceType,
    required this.profileImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

@JsonSerializable()
class CompanyBean {
  num id;
  String name;

  CompanyBean({required this.id, required this.name});

  factory CompanyBean.fromJson(Map<String, dynamic> json) =>
      _$CompanyBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyBeanToJson(this);
}
