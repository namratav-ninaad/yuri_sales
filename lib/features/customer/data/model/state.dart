import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class StateModel {
  num id;
  String name;
  String code;
  CountryBean country;

  StateModel({
    required this.id,
    required this.name,
    required this.code,
    required this.country,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => _$StateModelFromJson(json);

  Map<String, dynamic> toJson() => _$StateModelToJson(this);
}

@JsonSerializable()
class CountryBean {
  num id;
  String name;
  String code;

  CountryBean({required this.id, required this.name, required this.code});

  factory CountryBean.fromJson(Map<String, dynamic> json) =>
      _$CountryBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CountryBeanToJson(this);
}
