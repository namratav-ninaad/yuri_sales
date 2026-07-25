import 'package:json_annotation/json_annotation.dart';
part 'company_model.g.dart';

@JsonSerializable()
class CompanyModel {
  num id;
  String name;
  String email;
  String phone;
  String mobile;
  String website;
  String vat;
  String street;
  String street2;
  String city;
  String zip;
  num state_id;
  String state;
  num country_id;
  String country;
  num currency_id;
  String currency;
  String logo;

  CompanyModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.mobile,
    required this.website,
    required this.vat,
    required this.street,
    required this.street2,
    required this.city,
    required this.zip,
    required this.state_id,
    required this.state,
    required this.country_id,
    required this.country,
    required this.currency_id,
    required this.currency,
    required this.logo,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}
