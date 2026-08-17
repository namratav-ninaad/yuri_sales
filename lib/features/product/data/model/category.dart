import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryModel {
  final int id;
  final String name;

  @JsonKey(name: 'parent_id')
  final int? parentId;

  @JsonKey(name: 'parent_name')
  final String? parentName;

  const CategoryModel({
    required this.id,
    required this.name,
    this.parentId,
    this.parentName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}