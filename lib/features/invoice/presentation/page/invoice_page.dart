import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/routes/routes_name.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_circular_progress_indicator.dart';
import 'package:yuri_sale/core/widgets/common_empty_text.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/features/invoice/domain/entities/search_invoice_data.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_event.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_state.dart';
import 'package:yuri_sale/features/invoice/presentation/widget/invoice_card.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key, required this.partnerId});

  final int partnerId;

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<InvoiceBloc>().add(ResetInvoiceEvent());
    context.read<InvoiceBloc>().add(
      FetchInvoicesEvent(
        data: SearchInvoiceData(invoiceNumber: '', partnerId: widget.partnerId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        title: AppStringsConstants.invoices,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSizes.hS100),
          child: Container(
            height: AppSizes.hS45,
            margin: EdgeInsets.symmetric(vertical: AppSizes.p24),
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
            child: CommonTextFormField(
              onFieldSubmitted: (value) {
                context.read<InvoiceBloc>().add(
                  FetchInvoicesEvent(
                    data: SearchInvoiceData(
                      invoiceNumber: value,
                      partnerId: widget.partnerId,
                    ),
                  ),
                );
              },
              prefixIcon: Icons.search_outlined,
              controller: searchController,
              labelText: AppStringsConstants.searchInvoice,
            ),
          ),
        ),
      ),
      body: BlocBuilder<InvoiceBloc, InvoiceState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(child: CommonCircularProgressIndicator())
              : state.invoices.isEmpty
              ? CommonEmptyText(title: AppStringsConstants.noInvoiceData)
              : ListView.separated(
                  separatorBuilder: (context, index) => AppSizes.h12,
                  shrinkWrap: true,
                  itemCount: state.invoices.length,
                  itemBuilder: (context, index) => InvoiceCard(
                    invoice: state.invoices[index],
                    onTap: () => AppRoutes.pushNamed(
                      RouteNames.invoiceDetailPage,
                      arguments: state.invoices[index],
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.p24,
                    0,
                    AppSizes.p24,
                    AppSizes.p24,
                  ),
                );
        },
      ),
    );
  }
}
