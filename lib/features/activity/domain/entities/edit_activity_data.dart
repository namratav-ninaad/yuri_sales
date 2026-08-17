import 'package:yuri_sale/features/activity/data/model/activity.dart';

class EditActivityData {
  final int partnerId;
  final ActivityItemModel? activityModel;

  EditActivityData({
    required this.partnerId,
    this.activityModel,
  });

  Map<String, dynamic> toJson() {
    return {
      "partner_id": partnerId,
      "activityModel": activityModel,
    };
  }
}