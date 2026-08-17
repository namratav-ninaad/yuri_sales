import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/features/log_note/data/model/log_note.dart';
import 'package:yuri_sale/features/log_note/presentation/bloc/log_note_bloc.dart';
import 'package:yuri_sale/features/log_note/presentation/bloc/log_note_event.dart';
import 'package:yuri_sale/features/log_note/presentation/bloc/log_note_state.dart';
import 'package:yuri_sale/features/log_note/presentation/widget/add_log_note_bs.dart';
import 'package:yuri_sale/features/log_note/presentation/widget/delete_dialog.dart';
import 'package:yuri_sale/features/log_note/presentation/widget/log_note_card.dart';

class LogNotePage extends StatefulWidget {
  const LogNotePage({super.key, required this.partnerId});

  final int partnerId;

  @override
  State<LogNotePage> createState() => _LogNotePageState();
}

class _LogNotePageState extends State<LogNotePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LogNoteBloc>().add(
      FetchLogNotesEvent(partnerId: widget.partnerId),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _openAddNoteSheet({LogNoteModel? note}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          AddLogNoteBottomSheet(note: note, partnerId: widget.partnerId),
    );
  }

  void _confirmDelete(LogNoteModel note) {
    showDialog(
      context: context,
      builder: (ctx) {
        return DeleteDialog(note: note, partnerId: widget.partnerId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        title: AppStringsConstants.logNote,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSizes.s60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.p24,
              0,
              AppSizes.p24,
              AppSizes.p16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CommonTextFormField(
                    controller: searchController,
                    prefixIcon: Icons.search_outlined,
                    labelText: AppStringsConstants.searchLogNote,
                    onFieldSubmitted: (value) {},
                  ),
                ),
                AppSizes.w12,
                GestureDetector(
                  onTap: () => _openAddNoteSheet(),
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.p12),
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
      body: BlocConsumer<LogNoteBloc, LogNoteState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ToastHelper.error(state.errorMessage!);
          }
          if (state.isSuccess && state.successMessage != null) {
            ToastHelper.success(state.successMessage!);
          }
        },
        builder: (context, state) {
          List<LogNoteModel> logNotes = [];
          if (state.logNotes.isNotEmpty) {
            logNotes = state.logNotes
                .where((e) => e.messageType == AppStringsConstants.comment)
                .toList();
          }
          return state.isLoading
              ? const Center(child: CommonCircularProgressIndicator())
              : logNotes.isEmpty
              ? CommonEmptyText(title: AppStringsConstants.noLogNoteData)
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.p24,
                    0,
                    AppSizes.p24,
                    AppSizes.p24,
                  ),
                  itemCount: logNotes.length,
                  separatorBuilder: (_, index) => AppSizes.h12,
                  itemBuilder: (context, index) {
                    final note = logNotes[index];
                    return LogNoteCard(
                      note: note,
                      onEdit: () => _openAddNoteSheet(note: note),
                      onDelete: () => _confirmDelete(note),
                    );
                  },
                );
        },
      ),
    );
  }
}
