import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_bloc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_event.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_state.dart';

class BuildVoiceSection extends StatelessWidget {
  const BuildVoiceSection({super.key, required this.state, required this.bloc});

  final CreateCustomerState state;
  final CreateCustomerBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: state.isRecording
                ? () => bloc.add(StopRecording())
                : () => bloc.add(StartRecording()),
            child: Container(
              width: AppSizes.icon60,
              height: AppSizes.icon60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: state.isRecording
                    ? context.primaryRedColor.withValues(alpha: 0.1)
                    : AppColorsConstants.blue.withValues(alpha: 0.1),
              ),
              child: CommonIconWidget(
                icon: state.isRecording ? Icons.stop : Icons.mic,
                size: AppSizes.icon32,
                color: state.isRecording
                    ? context.primaryRedColor
                    : AppColorsConstants.blue,
              ),
            ),
          ),
          AppSizes.h12,
          CommonTextWidget(
            title: state.isRecording
                ? '${AppStringsConstants.recording}\t${state.recordingSeconds}\t${AppStringsConstants.sec}'
                : AppStringsConstants.tapToRecord,
            fontSize: AppSizes.f14,
            fontWeight: FontWeight.w700,
            color: context.black,
          ),
          if (state.recordedDuration.isNotEmpty)
            CommonTextWidget(
              title:
                  '${AppStringsConstants.recorded}\t${AppStringsConstants.colon}\t\t${state.recordedDuration}',
              fontSize: AppSizes.f12,
              fontWeight: FontWeight.w400,
              color: context.grey89,
            ),
        ],
      ),
    );
  }
}
