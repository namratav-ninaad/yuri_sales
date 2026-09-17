import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:yuri_sale/core/enum/app_enum.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';

class OrderState extends Equatable {
  final bool isLoading;
  final List<OrderModel> orders;
  final String? error;
  final OrderStatus? selectedStatus;

  // PDF fetch
  final bool isPdfLoading;
  final String? pdfErrorMessage;
  final Uint8List? quotationPdfBytes;
  final String? quotationPdfOrderNumber;

  // PDF sharing
  final bool isPdfSharing;
  final String? sharePdfErrorMessage;

  const OrderState({
    this.isLoading = false,
    this.orders = const [],
    this.error,
    this.selectedStatus,

    this.isPdfLoading = false,
    this.pdfErrorMessage,
    this.quotationPdfBytes,
    this.quotationPdfOrderNumber,

    this.isPdfSharing = false,
    this.sharePdfErrorMessage,
  });

  OrderState copyWith({
    bool? isLoading,
    List<OrderModel>? orders,
    String? error,
    OrderStatus? selectedStatus,

    bool? isPdfLoading,
    String? pdfErrorMessage,
    Uint8List? quotationPdfBytes,
    String? quotationPdfOrderNumber,
    bool clearPdfError = false,

    bool? isPdfSharing,
    String? sharePdfErrorMessage,
    bool clearSharePdfError = false,
  }) {
    return OrderState(
      selectedStatus: selectedStatus ?? this.selectedStatus,
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: error,

      isPdfLoading: isPdfLoading ?? this.isPdfLoading,
      pdfErrorMessage: clearPdfError
          ? null
          : pdfErrorMessage ?? this.pdfErrorMessage,
      quotationPdfBytes: quotationPdfBytes ?? this.quotationPdfBytes,

      quotationPdfOrderNumber:
          quotationPdfOrderNumber ?? this.quotationPdfOrderNumber,

      isPdfSharing: isPdfSharing ?? this.isPdfSharing,

      sharePdfErrorMessage: clearSharePdfError
          ? null
          : sharePdfErrorMessage ?? this.sharePdfErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    orders,
    error,
    selectedStatus,

    isPdfLoading,
    pdfErrorMessage,
    quotationPdfBytes,
    quotationPdfOrderNumber,

    isPdfSharing,
    sharePdfErrorMessage,
  ];
}
