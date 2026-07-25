import 'package:json_annotation/json_annotation.dart';

part 'payment_terms.g.dart';

@JsonSerializable()
class PaymentTermsModel {
  num id;
  String name;
  bool active;
  String create_date;
  String write_date;

  PaymentTermsModel({
    required this.id,
    required this.name,
    required this.active,
    required this.create_date,
    required this.write_date,
  });

  factory PaymentTermsModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentTermsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTermsModelToJson(this);
}
