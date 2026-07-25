import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  num user_id;
  String full_name;
  String email;
  String phone;
  CompanyBean company;
  String device_type;
  String profile_image;

  ProfileModel({
    required this.user_id,
    required this.full_name,
    required this.email,
    required this.phone,
    required this.company,
    required this.device_type,
    required this.profile_image,
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
