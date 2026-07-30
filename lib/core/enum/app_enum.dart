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

enum DeliveryStatus {
  waiting,
  ready,
  cancelled,
  done;

  String get label {
    switch (this) {
      case DeliveryStatus.waiting:
        return AppStringsConstants.waiting;

      case DeliveryStatus.ready:
        return AppStringsConstants.ready;

      case DeliveryStatus.cancelled:
        return AppStringsConstants.cancelled;

      case DeliveryStatus.done:
        return AppStringsConstants.done;
    }
  }

  Color get color {
    switch (this) {
      case DeliveryStatus.waiting:
        return AppColorsConstants.orange;

      case DeliveryStatus.ready:
        return AppColorsConstants.blue;

      case DeliveryStatus.cancelled:
        return AppColorsConstants.red;

      case DeliveryStatus.done:
        return AppColorsConstants.green;
    }
  }

  static DeliveryStatus fromString(String value) {
    switch (value.toLowerCase().trim()) {
      case AppStringsConstants.waitingL:
        return DeliveryStatus.waiting;

      case AppStringsConstants.readyL:
        return DeliveryStatus.ready;

      case AppStringsConstants.cancelledL:
      case AppStringsConstants.cancelL:
        return DeliveryStatus.cancelled;

      case AppStringsConstants.doneL:
        return DeliveryStatus.done;

      default:
        return DeliveryStatus.waiting;
    }
  }
}

enum InvoicePaymentStatus {
  draft,
  notPaid,
  paid,
  cancelled;

  String get label {
    switch (this) {
      case InvoicePaymentStatus.draft:
        return AppStringsConstants.draft;

      case InvoicePaymentStatus.notPaid:
        return AppStringsConstants.notPaid;

      case InvoicePaymentStatus.paid:
        return AppStringsConstants.paid;

      case InvoicePaymentStatus.cancelled:
        return AppStringsConstants.cancelled;
    }
  }

  Color get color {
    switch (this) {
      case InvoicePaymentStatus.draft:
        return AppColorsConstants.orange;

      case InvoicePaymentStatus.notPaid:
        return AppColorsConstants.red;

      case InvoicePaymentStatus.paid:
        return AppColorsConstants.green;

      case InvoicePaymentStatus.cancelled:
        return AppColorsConstants.grey89;
    }
  }

  static InvoicePaymentStatus fromString(String value) {
    switch (value.toLowerCase().trim()) {
      case AppStringsConstants.draftL:
        return InvoicePaymentStatus.draft;

      case AppStringsConstants.notPaidL:
      case AppStringsConstants.notUPaid:
      case AppStringsConstants.unpaid:
        return InvoicePaymentStatus.notPaid;

      case AppStringsConstants.paidL:
        return InvoicePaymentStatus.paid;

      case AppStringsConstants.cancelledL:
      case AppStringsConstants.cancel:
        return InvoicePaymentStatus.cancelled;

      default:
        return InvoicePaymentStatus.draft;
    }
  }
}
