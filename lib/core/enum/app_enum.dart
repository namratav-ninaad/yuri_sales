import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';

enum NoteType {
  text,
  // voice,
  followup;

  bool get isText => this == NoteType.text;

  // bool get isVoice => this == NoteType.voice;

  bool get isFollowUp => this == NoteType.followup;

  // Label for display
  String get label {
    switch (this) {
      case NoteType.text:
        return AppStringsConstants.text;
      // case NoteType.voice:
      //   return AppStringsConstants.voice;
      case NoteType.followup:
        return AppStringsConstants.followUp;
    }
  }

  // Icon for UI
  IconData get icon {
    switch (this) {
      case NoteType.text:
        return Icons.text_fields_outlined;
      // case NoteType.voice:
      //   return Icons.mic_none_outlined;
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

enum OrderStatus {
  draft,
  sent,
  sale,
  cancel;

  String get label => switch (this) {
    OrderStatus.draft => AppStringsConstants.quotation,
    OrderStatus.sent => AppStringsConstants.quotationSent,
    OrderStatus.sale => AppStringsConstants.saleOrder,
    OrderStatus.cancel => AppStringsConstants.cancelled,
  };

  Color get color => switch (this) {
    OrderStatus.draft => AppColorsConstants.grey89,
    OrderStatus.sent => AppColorsConstants.blue,
    OrderStatus.sale => AppColorsConstants.green,
    OrderStatus.cancel => AppColorsConstants.red,
  };

  String get apiValue => switch (this) {
    OrderStatus.draft => AppStringsConstants.draftL,
    OrderStatus.sent => AppStringsConstants.sentL,
    OrderStatus.sale => AppStringsConstants.saleL,
    OrderStatus.cancel => AppStringsConstants.cancelL,
  };

  static OrderStatus? fromString(String value) {
    final status = value.toLowerCase().trim();

    return switch (status) {
      AppStringsConstants.draftL => OrderStatus.draft,
      AppStringsConstants.sentL => OrderStatus.sent,
      AppStringsConstants.saleL => OrderStatus.sale,
      AppStringsConstants.cancelL => OrderStatus.cancel,
      _ => null,
    };
  }
}

enum DeliveryStatus {
  draft,
  waiting,
  confirmed,
  assigned,
  done,
  cancel;

  String get label => switch (this) {
    DeliveryStatus.draft => AppStringsConstants.draft,
    DeliveryStatus.waiting => AppStringsConstants.waitingAnother,
    DeliveryStatus.confirmed => AppStringsConstants.waiting,
    DeliveryStatus.assigned => AppStringsConstants.ready,
    DeliveryStatus.done => AppStringsConstants.done,
    DeliveryStatus.cancel => AppStringsConstants.cancelled,
  };

  String get apiValue => switch (this) {
    DeliveryStatus.draft => AppStringsConstants.draftL,
    DeliveryStatus.waiting => AppStringsConstants.waitingL,
    DeliveryStatus.confirmed => AppStringsConstants.confirmedL,
    DeliveryStatus.assigned => AppStringsConstants.assignedL,
    DeliveryStatus.done => AppStringsConstants.doneL,
    DeliveryStatus.cancel => AppStringsConstants.cancelL,
  };

  Color get color => switch (this) {
    DeliveryStatus.draft => AppColorsConstants.grey89,
    DeliveryStatus.waiting => AppColorsConstants.orange,
    DeliveryStatus.confirmed => AppColorsConstants.blue,
    DeliveryStatus.assigned => AppColorsConstants.blue,
    DeliveryStatus.done => AppColorsConstants.green,
    DeliveryStatus.cancel => AppColorsConstants.red,
  };

  static DeliveryStatus fromString(String value) {
    final status = value.toLowerCase().trim();

    return switch (status) {
      AppStringsConstants.draftL => DeliveryStatus.draft,
      AppStringsConstants.waitingL => DeliveryStatus.waiting,
      AppStringsConstants.confirmedL => DeliveryStatus.confirmed,
      AppStringsConstants.assignedL => DeliveryStatus.assigned,
      AppStringsConstants.doneL => DeliveryStatus.done,
      AppStringsConstants.cancelL => DeliveryStatus.cancel,
      _ => DeliveryStatus.draft,
    };
  }
}

enum InvoiceStatus {
  draft,
  posted,
  cancel;

  String get label => switch (this) {
    InvoiceStatus.draft => AppStringsConstants.draft,
    InvoiceStatus.posted => AppStringsConstants.posted,
    InvoiceStatus.cancel => AppStringsConstants.cancelled,
  };

  String get apiValue => switch (this) {
    InvoiceStatus.draft => AppStringsConstants.draftL,
    InvoiceStatus.posted => AppStringsConstants.postedL,
    InvoiceStatus.cancel => AppStringsConstants.cancelL,
  };

  Color get color => switch (this) {
    InvoiceStatus.draft => AppColorsConstants.grey89,
    InvoiceStatus.posted => AppColorsConstants.green,
    InvoiceStatus.cancel => AppColorsConstants.red,
  };

  static InvoiceStatus fromString(String value) {
    final status = value.toLowerCase().trim();

    return switch (status) {
      AppStringsConstants.draftL => InvoiceStatus.draft,
      AppStringsConstants.postedL => InvoiceStatus.posted,
      AppStringsConstants.cancelL => InvoiceStatus.cancel,
      _ => InvoiceStatus.draft,
    };
  }
}

enum ActivityType {
  todo,
  call,
  email;

  /// UI Label
  String get label {
    switch (this) {
      case ActivityType.todo:
        return AppStringsConstants.todo;
      case ActivityType.call:
        return AppStringsConstants.call;
      case ActivityType.email:
        return AppStringsConstants.email;
    }
  }

  /// API Value
  String get apiValue {
    switch (this) {
      case ActivityType.todo:
        return AppStringsConstants.todoL;
      case ActivityType.call:
        return AppStringsConstants.callL;
      case ActivityType.email:
        return AppStringsConstants.emailL;
    }
  }

  /// Convert API value to enum
  static ActivityType fromApi(String value) {
    switch (value.toLowerCase()) {
      case AppStringsConstants.todoL:
        return ActivityType.todo;
      case AppStringsConstants.callL:
        return ActivityType.call;
      case AppStringsConstants.emailL:
        return ActivityType.email;
      default:
        return ActivityType.todo;
    }
  }

  /// Convert label to enum
  static ActivityType fromLabel(String value) {
    switch (value) {
      case AppStringsConstants.todo:
        return ActivityType.todo;
      case AppStringsConstants.call:
        return ActivityType.call;
      case AppStringsConstants.email:
        return ActivityType.email;
      default:
        return ActivityType.todo;
    }
  }
}
