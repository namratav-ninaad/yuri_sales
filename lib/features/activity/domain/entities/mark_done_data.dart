class MarkDoneData {
  final int activityId;
  final String feedback;

  MarkDoneData({required this.activityId, required this.feedback});

  Map<String, dynamic> toJson() {
    return {'activity_id': activityId, 'feedback': feedback};
  }
}
