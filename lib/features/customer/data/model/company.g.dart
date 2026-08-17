// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
  id: json['id'] as num,
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  mobile: json['mobile'] as String,
  website: json['website'] as String,
  vat: json['vat'] as String,
  street: json['street'] as String,
  street2: json['street2'] as String,
  city: json['city'] as String,
  zip: json['zip'] as String,
  stateId: json['state_id'] as num,
  state: json['state'] as String,
  countryId: json['country_id'] as num,
  country: json['country'] as String,
  currencyId: json['currency_id'] as num,
  currency: json['currency'] as String,
  logo: json['logo'] as String,
);

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'mobile': instance.mobile,
      'website': instance.website,
      'vat': instance.vat,
      'street': instance.street,
      'street2': instance.street2,
      'city': instance.city,
      'zip': instance.zip,
      'state_id': instance.stateId,
      'state': instance.state,
      'country_id': instance.countryId,
      'country': instance.country,
      'currency_id': instance.currencyId,
      'currency': instance.currency,
      'logo': instance.logo,
    };
