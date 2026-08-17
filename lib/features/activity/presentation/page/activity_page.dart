import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/features/activity/domain/entities/edit_activity_data.dart';
import 'package:yuri_sale/features/activity/domain/entities/mark_done_data.dart';
import 'package:yuri_sale/features/activity/presentation/bloc/activity_bloc.dart';
import 'package:yuri_sale/features/activity/presentation/bloc/activity_event.dart';
import 'package:yuri_sale/features/activity/presentation/bloc/activity_state.dart';
import 'package:yuri_sale/features/activity/presentation/widget/activity_card.dart';
import 'package:yuri_sale/features/activity/presentation/widget/mark_done_bs.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key, required this.partnerId});

  final int partnerId;

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ActivityBloc>().add(ResetActivityEvent());
    context.read<ActivityBloc>().add(FetchActivitiesEvent(widget.partnerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        title: AppStringsConstants.activity,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSizes.s60),
          child: Container(
            height: AppSizes.s45,
            margin: EdgeInsets.symmetric(vertical: AppSizes.p24),
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
            child: Row(
              children: [
                Expanded(
                  child: CommonTextFormField(
                    onFieldSubmitted: (value) {},
                    prefixIcon: Icons.search_outlined,
                    controller: searchController,
                    labelText: AppStringsConstants.searchActivity,
                  ),
                ),
                AppSizes.w12,
                GestureDetector(
                  onTap: () => AppRoutes.pushNamed(
                    RouteNames.scheduleActivityPage,
                    arguments: EditActivityData(partnerId: widget.partnerId),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(AppSizes.p8),
                    decoration: BoxDecoration(
                      // border: Border.all(color: context.greyC8),
                      color: context.greyFA,
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                    ),
                    child: CommonIconWidget(
                      icon: Icons.add_circle_outline,
                      size: AppSizes.icon24,
                      color: context.primaryRedColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocConsumer<ActivityBloc, ActivityState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ToastHelper.error(state.errorMessage!);
          }
        },
        builder: (context, state) => state.isLoading
            ? const Center(child: CommonCircularProgressIndicator())
            : state.activities.isEmpty
            ? CommonEmptyText(title: AppStringsConstants.noActivityData)
            : ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  AppSizes.p24,
                  0,
                  AppSizes.p24,
                  AppSizes.p24,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var activity = state.activities[index];
                  return ActivityCard(
                    activity: activity,
                    onMarkDone: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => MarkDoneBottomSheet(
                          onDone: (feedback) {
                            context.read<ActivityBloc>().add(
                              MarkDoneActivityEvent(
                                partnerId: state.activity?.partnerId ?? 0,
                                data: MarkDoneData(
                                  activityId: activity.activityId,
                                  feedback: feedback,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    onEdit: () => AppRoutes.pushNamed(
                      RouteNames.scheduleActivityPage,

                      arguments: EditActivityData(
                        partnerId: state.activity?.partnerId ?? 0,
                        activityModel: activity,
                      ),
                    ),
                    onCancel: () {
                      context.read<ActivityBloc>().add(
                        DeleteActivityEvent(
                          activityId: activity.activityId,
                          partnerId: state.activity?.partnerId ?? 0,
                        ),
                      );
                    },
                  );
                },
                itemCount: state.activities.length,
                separatorBuilder: (context, index) => AppSizes.h12,
              ),
      ),
    );
  }
}
