import 'package:json_annotation/json_annotation.dart';
part 'company.g.dart';

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
  @JsonKey(name: 'state_id')
  num stateId;
  String state;
  @JsonKey(name: 'country_id')
  num countryId;
  String country;
  @JsonKey(name: 'currency_id')
  num currencyId;
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
    required this.stateId,
    required this.state,
    required this.countryId,
    required this.country,
    required this.currencyId,
    required this.currency,
    required this.logo,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}
