import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/features/order/domain/entities/quotation_pdf_data.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_bloc.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_event.dart';
import 'package:yuri_sale/features/order/presentation/bloc/order_state.dart';

class QuotationPdfPage extends StatelessWidget {
  const QuotationPdfPage({super.key, required this.quotationPdfData});

  final QuotationPdfData quotationPdfData;

  @override
  Widget build(BuildContext context) {
    final pdfBytes = quotationPdfData.pdfBytes;

    return BlocListener<OrderBloc, OrderState>(
      listenWhen: (previous, current) =>
          previous.sharePdfErrorMessage != current.sharePdfErrorMessage,
      listener: (context, state) {
        final errorMessage = state.sharePdfErrorMessage;

        if (errorMessage != null && errorMessage.isNotEmpty) {
          ToastHelper.error(errorMessage);
        }
      },
      child: Scaffold(
        backgroundColor: context.white,

        appBar: CommonAppbarWidget(
          title: quotationPdfData.orderNumber,
          action: [
            BlocBuilder<OrderBloc, OrderState>(
              buildWhen: (previous, current) =>
                  previous.isPdfSharing != current.isPdfSharing,
              builder: (context, state) {
                return CommonIconWidget(
                  icon: Icons.share_outlined,
                  color: context.black,
                  size: AppSizes.icon24,
                  onTap: state.isPdfSharing
                      ? null
                      : () {
                          _sharePdf(context, pdfBytes);
                        },
                );
              },
            ),
            AppSizes.w24,
          ],
        ),

        body: _buildPdfViewer(pdfBytes),
      ),
    );
  }

  Widget _buildPdfViewer(Uint8List? pdfBytes) {
    if (pdfBytes == null || pdfBytes.isEmpty) {
      return const Center(
        child: CommonEmptyText(
          title: AppStringsConstants.quotationPdfNotAvailable,
        ),
      );
    }

    return SfPdfViewer.memory(
      pdfBytes,
      canShowScrollHead: true,
      canShowScrollStatus: true,
      enableDoubleTapZooming: true,

    );
  }

  void _sharePdf(BuildContext context, Uint8List? pdfBytes) {
    if (pdfBytes == null || pdfBytes.isEmpty) {
      ToastHelper.error(AppStringsConstants.pdfNotSharing);
      return;
    }

    context.read<OrderBloc>().add(
      ShareQuotationPdfEvent(
        pdfBytes: pdfBytes,
        orderNumber: quotationPdfData.orderNumber,
      ),
    );
  }
}
