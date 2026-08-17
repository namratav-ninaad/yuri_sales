import 'package:json_annotation/json_annotation.dart';

part 'contact_tag.g.dart';

@JsonSerializable()
class ContactTagModel {
  num id;
  String name;
  bool active;
  @JsonKey(name: 'create_date')
  String createDate;
  @JsonKey(name: 'write_date')
  String writeDate;

  ContactTagModel({
    required this.id,
    required this.name,
    required this.active,
    required this.createDate,
    required this.writeDate,
  });

  factory ContactTagModel.fromJson(Map<String, dynamic> json) =>
      _$ContactTagModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactTagModelToJson(this);
}
