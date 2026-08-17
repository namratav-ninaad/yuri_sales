import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_date_picker.dart';
import 'package:yuri_sale/core/widgets/common_drop_down.dart';
import 'package:yuri_sale/core/widgets/common_outline_button.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/core/widgets/date_helper.dart';
import 'package:yuri_sale/features/activity/data/model/user.dart';
import 'package:yuri_sale/features/activity/domain/entities/edit_activity_data.dart';
import 'package:yuri_sale/features/activity/domain/entities/mark_done_data.dart';
import 'package:yuri_sale/features/activity/domain/entities/schedule_activity_data.dart';
import 'package:yuri_sale/features/activity/presentation/bloc/activity_bloc.dart';
import 'package:yuri_sale/features/activity/presentation/bloc/activity_event.dart';
import 'package:yuri_sale/features/activity/presentation/bloc/activity_state.dart';
import 'package:yuri_sale/features/activity/presentation/widget/mark_done_bs.dart';

class ScheduleActivityPage extends StatefulWidget {
  const ScheduleActivityPage({super.key, required this.data});

  final EditActivityData data;

  @override
  State<ScheduleActivityPage> createState() => _ScheduleActivityPageState();
}

class _ScheduleActivityPageState extends State<ScheduleActivityPage> {
  late final TextEditingController summaryController;
  late final TextEditingController noteController;

  final List<ActivityType> activityList = ActivityType.values;

  /// Strips HTML tags and trims the result
  String _stripHtml(String? html) {
    if (html == null || html.isEmpty) return '';
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '') // remove all tags
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .trim();
  }

  Future<void> _pickDate(DateTime dueDate) async {
    final date = await CommonDatePicker.pickDate(
      context: context,
      initialDate: dueDate,
    );

    if (date != null && mounted) {
      context.read<ActivityBloc>().add(DueDateChanged(date));
    }
  }

  @override
  void initState() {
    super.initState();

    final activity = widget.data.activityModel;
    var bloc = context.read<ActivityBloc>();
    summaryController = TextEditingController(text: activity?.summary ?? '');

    // Strip HTML from note so user sees plain text
    noteController = TextEditingController(text: _stripHtml(activity?.note));

    // Load customers + initialize activity state
    bloc.add(FetchUsersEvent());
    bloc.add(InitializeActivityEvent(activity));
  }

  @override
  void dispose() {
    summaryController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void createUpdateActivityButton(
    ActivityState state,
    ActivityBloc bloc, {
    bool isMarkDone = false,
  }) {
    if (state.assignedUser == null) {
      ToastHelper.error(AppStringsConstants.selectAssignedMsg);
      return;
    }
    var data = ScheduleActivityData(
      partnerId: widget.data.partnerId,
      activityType: state.activityType.apiValue,
      assignedTo: state.assignedUser!.id.toInt(),
      summary: summaryController.text.trim(),
      note: noteController.text.trim(),
      deadline: DateHelper.yMd(state.dueDate.toIso8601String()),
    );

    if (widget.data.activityModel != null) {
      bloc.add(UpdateActivityEvent(data));
    } else {
      bloc.add(CreateActivityEvent(data));
    }
    if (isMarkDone == false) {
      AppRoutes.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ActivityBloc>();

    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(title: AppStringsConstants.scheduleActivity),
      body: BlocConsumer<ActivityBloc, ActivityState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ToastHelper.error(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.p24),
            child: Column(
              children: [
                // ── Activity Type + Due Date ──
                Row(
                  children: [
                    Expanded(
                      child: CommonDropdown<ActivityType>(
                        initialValue: state.activityType,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(ActivityTypeChanged(value));
                          }
                        },
                        hintText: AppStringsConstants.activityType,
                        items: activityList,
                        itemLabel: (activity) => activity.label,
                        validator: (value) {
                          if (value == null) {
                            return AppStringsConstants.selectActivityMsg;
                          }
                          return null;
                        },
                      ),
                    ),
                    AppSizes.w12,
                    Expanded(
                      child: InkWell(
                        onTap: () => _pickDate(state.dueDate),
                        child: CommonTextFormField(
                          controller: TextEditingController(
                            text: DateHelper.dMySlash(
                              state.dueDate.toIso8601String(),
                            ),
                          ),
                          labelText: AppStringsConstants.dueDate,
                          enabled: false,
                          readOnly: true,
                          onTap: () => _pickDate(state.dueDate),
                        ),
                      ),
                    ),
                  ],
                ),
                AppSizes.h14,

                // ── Summary ──
                CommonTextFormField(
                  controller: summaryController,
                  labelText: AppStringsConstants.summary,
                ),
                AppSizes.h14,

                // ── Note (plain text) ──
                CommonTextFormField(
                  controller: noteController,
                  labelText: AppStringsConstants.logNote,
                  maxLines: 4,
                ),
                AppSizes.h14,

                // ── Assigned To ──
                CommonDropdown<UserModel>(
                  initialValue: state.assignedUser,
                  hintText: AppStringsConstants.assignedTo,
                  items: state.users,
                  itemLabel: (p0) => p0.name,
                  onChanged: (value) {
                    if (value != null) {
                      bloc.add(AssignedUserChanged(assignedUser: value));
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return AppStringsConstants.selectAssignedMsg;
                    }
                    return null;
                  },
                ),

                AppSizes.h60,

                // ── Action Buttons ──
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            isLoading: state.isLoading,
                            onTap: () =>
                                createUpdateActivityButton(state, bloc),
                            title: AppStringsConstants.schedule,
                          ),
                        ),

                        AppSizes.w12,
                        Expanded(
                          child: CommonOutlineButton(
                            textColor: context.primaryRedColor,
                            title: AppStringsConstants.cancel,
                            onTap: () => AppRoutes.pop(),
                          ),
                        ),
                      ],
                    ),
                    AppSizes.h12,
                    CommonOutlineButton(
                      onTap: () {
                        createUpdateActivityButton(
                          state,
                          bloc,
                          isMarkDone: true,
                        );
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => MarkDoneBottomSheet(
                            onDone: (feedback) {
                              context.read<ActivityBloc>().add(
                                MarkDoneActivityEvent(
                                  partnerId: widget.data.partnerId,
                                  data: MarkDoneData(
                                    activityId:
                                        widget.data.activityModel != null
                                        ? widget.data.activityModel!.activityId
                                        : state.activityId,
                                    feedback: feedback,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      title: AppStringsConstants.doneNote,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
