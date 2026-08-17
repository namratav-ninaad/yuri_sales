import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable(explicitToJson: true)
class ActivityModel {
  @JsonKey(name: 'partner_id')
  final int partnerId;

  @JsonKey(name: 'partner_name')
  final String partnerName;

  @JsonKey(name: 'total_activities')
  final int totalActivities;

  final List<ActivityItemModel> activities;

  const ActivityModel({
    required this.partnerId,
    required this.partnerName,
    required this.totalActivities,
    required this.activities,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}

@JsonSerializable()
class ActivityItemModel {
  @JsonKey(name: 'activity_id')
  final int activityId;

  @JsonKey(name: 'activity_type_id')
  final int? activityTypeId;

  @JsonKey(name: 'activity_type')
  final String activityType;

  final String summary;

  final String? note;

  @JsonKey(name: 'assigned_to_id')
  final int? assignedToId;

  @JsonKey(name: 'assigned_to')
  final String? assignedTo;

  final String deadline;

  final String? state;

  @JsonKey(name: 'recommended_next_type')
  final String? recommendedNextType;

  @JsonKey(name: 'create_date')
  final String createDate;

  @JsonKey(name: 'write_date')
  final String writeDate;

  const ActivityItemModel({
    required this.activityId,
    this.activityTypeId,
    required this.activityType,
    required this.summary,
    this.note,
    this.assignedToId,
    this.assignedTo,
    required this.deadline,
    this.state,
    this.recommendedNextType,
    required this.createDate,
    required this.writeDate,
  });

  factory ActivityItemModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityItemModelToJson(this);
}