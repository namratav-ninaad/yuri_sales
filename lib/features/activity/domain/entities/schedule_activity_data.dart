class ScheduleActivityData {
  final int partnerId;
  final String activityType;
  final int assignedTo;
  final String summary;
  final String note;
  final String deadline;

  ScheduleActivityData({
    required this.partnerId,
    required this.activityType,
    required this.assignedTo,
    required this.summary,
    required this.note,
    required this.deadline,
  });

  Map<String, dynamic> toJson() {
    return {
      "partner_id": partnerId,
      "activity_type": activityType,
      "assigned_to": assignedTo,
      "summary": summary,
      "note": note,
      "deadline": deadline,
    };
  }
}