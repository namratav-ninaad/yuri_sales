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

enum InvoiceStatus {
  invoiced,
  fullyInvoiced,
  toInvoice,
  no;

  String get label {
    switch (this) {
      case InvoiceStatus.invoiced:
        return AppStringsConstants.invoiced;
      case InvoiceStatus.fullyInvoiced:
        return AppStringsConstants.fullInvoiced;
      case InvoiceStatus.toInvoice:
        return AppStringsConstants.toInvoice;
      case InvoiceStatus.no:
        return AppStringsConstants.notInvoiced;
    }
  }

  Color get color {
    switch (this) {
      case InvoiceStatus.invoiced:
      case InvoiceStatus.fullyInvoiced:
        return AppColorsConstants.green;
      case InvoiceStatus.toInvoice:
        return AppColorsConstants.blue;
      case InvoiceStatus.no:
        return AppColorsConstants.red;
    }
  }

  static InvoiceStatus fromString(String value) {
    switch (value.toLowerCase().trim()) {
      case AppStringsConstants.invoicedL:
        return InvoiceStatus.invoiced;
      case AppStringsConstants.fullInvoicedL:
        return InvoiceStatus.fullyInvoiced;
      case AppStringsConstants.toInvoiceL:
        return InvoiceStatus.toInvoice;
      case AppStringsConstants.no:
        return InvoiceStatus.no;
      default:
        return InvoiceStatus.no;
    }
  }
}
