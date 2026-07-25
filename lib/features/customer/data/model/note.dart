import 'dart:ui';

import 'package:yuri_sale/core/enum/app_enum.dart';

class Note {
  final NoteType type; // 'text', 'voice', 'followup'
  final String title;
  final String time;
  final String content;
  final String label;
  final Color labelColor;
  final String? duration;
  final DateTime? followUpDate;

  Note({
    required this.type,
    required this.title,
    required this.time,
    required this.content,
    required this.label,
    required this.labelColor,
    this.duration,
    this.followUpDate,
  });
}