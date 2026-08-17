import 'package:json_annotation/json_annotation.dart';

part 'payment_terms.g.dart';

@JsonSerializable()
class PaymentTermsModel {
  num id;
  String name;
  bool active;

  @JsonKey(name: 'create_date')
  String createDate;

  @JsonKey(name: 'write_date')
  String writeDate;

  PaymentTermsModel({
    required this.id,
    required this.name,
    required this.active,
    required this.createDate,
    required this.writeDate,
  });

  factory PaymentTermsModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentTermsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTermsModelToJson(this);
}
