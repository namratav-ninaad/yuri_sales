// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      partnerId: (json['partner_id'] as num).toInt(),
      partnerName: json['partner_name'] as String,
      totalActivities: (json['total_activities'] as num).toInt(),
      activities: (json['activities'] as List<dynamic>)
          .map((e) => ActivityItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'partner_id': instance.partnerId,
      'partner_name': instance.partnerName,
      'total_activities': instance.totalActivities,
      'activities': instance.activities.map((e) => e.toJson()).toList(),
    };

ActivityItemModel _$ActivityItemModelFromJson(Map<String, dynamic> json) =>
    ActivityItemModel(
      activityId: (json['activity_id'] as num).toInt(),
      activityTypeId: (json['activity_type_id'] as num?)?.toInt(),
      activityType: json['activity_type'] as String,
      summary: json['summary'] as String,
      note: json['note'] as String?,
      assignedToId: (json['assigned_to_id'] as num?)?.toInt(),
      assignedTo: json['assigned_to'] as String?,
      deadline: json['deadline'] as String,
      state: json['state'] as String?,
      recommendedNextType: json['recommended_next_type'] as String?,
      createDate: json['create_date'] as String,
      writeDate: json['write_date'] as String,
    );

Map<String, dynamic> _$ActivityItemModelToJson(ActivityItemModel instance) =>
    <String, dynamic>{
      'activity_id': instance.activityId,
      'activity_type_id': instance.activityTypeId,
      'activity_type': instance.activityType,
      'summary': instance.summary,
      'note': instance.note,
      'assigned_to_id': instance.assignedToId,
      'assigned_to': instance.assignedTo,
      'deadline': instance.deadline,
      'state': instance.state,
      'recommended_next_type': instance.recommendedNextType,
      'create_date': instance.createDate,
      'write_date': instance.writeDate,
    };
