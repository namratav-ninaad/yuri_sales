import 'package:json_annotation/json_annotation.dart';

part 'contact_tag.g.dart';

@JsonSerializable()
class ContactTagModel {
  num id;
  String name;
  bool active;
  String create_date;
  String write_date;

  ContactTagModel({
    required this.id,
    required this.name,
    required this.active,
    required this.create_date,
    required this.write_date,
  });

  factory ContactTagModel.fromJson(Map<String, dynamic> json) =>
      _$ContactTagModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactTagModelToJson(this);
}
