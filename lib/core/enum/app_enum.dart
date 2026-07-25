// lib/features/customer/data/model/note_type.dart

import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';

enum NoteType {
  text,
  voice,
  followup;

  bool get isText => this == NoteType.text;

  bool get isVoice => this == NoteType.voice;

  bool get isFollowUp => this == NoteType.followup;

  // Label for display
  String get label {
    switch (this) {
      case NoteType.text:
        return AppStringsConstants.text;
      case NoteType.voice:
        return AppStringsConstants.voice;
      case NoteType.followup:
        return AppStringsConstants.followUp;
    }
  }

  // Icon for UI
  IconData get icon {
    switch (this) {
      case NoteType.text:
        return Icons.text_fields_outlined;
      case NoteType.voice:
        return Icons.mic_none_outlined;
      case NoteType.followup:
        return Icons.calendar_today_outlined;
    }
  }

  // Color for chips/labels
  Color get color {
    switch (this) {
      case NoteType.text:
        return AppColorsConstants.green;
      case NoteType.voice:
        return AppColorsConstants.blue;
      case NoteType.followup:
        return AppColorsConstants.orange;
    }
  }
}

enum AddressType {
  gpsLocation,
  shippingAddress,
  billingAddress;

  bool get isGpsLocation => this == AddressType.gpsLocation;

  bool get isShippingAddress => this == AddressType.shippingAddress;

  bool get isBillingAddress => this == AddressType.billingAddress;

  String get label {
    switch (this) {
      case AddressType.gpsLocation:
        return AppStringsConstants.gpsLocation;
      case AddressType.shippingAddress:
        return AppStringsConstants.shippingAddress;
      case AddressType.billingAddress:
        return AppStringsConstants.billingAddress;
    }
  }
}
