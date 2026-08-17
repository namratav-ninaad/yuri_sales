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
import 'package:yuri_sale/features/invoice/domain/entities/invoice_data.dart';
import 'package:yuri_sale/features/invoice/domain/entities/invoice_detail_data.dart';
import 'package:yuri_sale/features/invoice/domain/entities/search_invoice_data.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_event.dart';
import 'package:yuri_sale/features/invoice/presentation/bloc/invoice_state.dart';
import 'package:yuri_sale/features/invoice/presentation/widget/invoice_card.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key, required this.data});

  final InvoiceData data;

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
        data: SearchInvoiceData(
          invoiceNumber: '',
          partnerId: widget.data.partnerId,
          outStanding: widget.data.isCustomer ? true : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        title: widget.data.isCustomer
            ? AppStringsConstants.customerStatement
            : AppStringsConstants.invoices,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSizes.s80),
          child: Container(
            height: AppSizes.s45,
            margin: EdgeInsets.symmetric(vertical: AppSizes.p24),
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
            child: CommonTextFormField(
              onFieldSubmitted: (value) {
                context.read<InvoiceBloc>().add(
                  FetchInvoicesEvent(
                    data: SearchInvoiceData(
                      invoiceNumber: value,
                      partnerId: widget.data.partnerId,
                      outStanding: widget.data.isCustomer ? true : null,
                    ),
                  ),
                );
              },
              prefixIcon: Icons.search_outlined,
              controller: searchController,
              labelText: widget.data.isCustomer
                  ? AppStringsConstants.searchCustomerStatement
                  : AppStringsConstants.searchInvoice,
            ),
          ),
        ),
      ),
      body: BlocBuilder<InvoiceBloc, InvoiceState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(child: CommonCircularProgressIndicator())
              : state.invoices.isEmpty
              ? CommonEmptyText(
                  title: widget.data.isCustomer
                      ? AppStringsConstants.noCustomerStatementData
                      : AppStringsConstants.noInvoiceData,
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => AppSizes.h12,
                  shrinkWrap: true,
                  itemCount: state.invoices.length,
                  itemBuilder: (context, index) => InvoiceCard(
                    invoice: state.invoices[index],
                    onTap: () => AppRoutes.pushNamed(
                      RouteNames.invoiceDetailPage,
                      arguments: InvoiceDetailData(
                        invoiceModel: state.invoices[index],
                        isCustomer: widget.data.isCustomer,
                      ),
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
