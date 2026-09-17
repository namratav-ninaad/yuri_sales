import 'dart:typed_data';

class QuotationPdfData {
  final String orderNumber;
  final String pdfUrl;
  final Uint8List? pdfBytes;

  const QuotationPdfData({
    required this.orderNumber,
    required this.pdfUrl,
    this.pdfBytes,
  });

  QuotationPdfData copyWith({
    String? orderNumber,
    String? pdfUrl,
    Uint8List? pdfBytes,
  }) {
    return QuotationPdfData(
      orderNumber: orderNumber ?? this.orderNumber,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      pdfBytes: pdfBytes ?? this.pdfBytes,
    );
  }
}