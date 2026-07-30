import 'package:flutter/material.dart';
import 'package:yuri_sale/features/customer/presentation/widget/customer_card_widget.dart';
import 'package:yuri_sale/features/customer/presentation/widget/finacial_summary_card.dart';
import 'package:yuri_sale/features/customer/presentation/widget/invoice_tile.dart';
import 'package:yuri_sale/features/customer/presentation/widget/statement_action_button.dart';

class CustomerStatementPage extends StatelessWidget {
  const CustomerStatementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer Statement")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search Customer",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          CustomerCardWidget(),

          const SizedBox(height: 20),

          FinancialSummaryCard(),

          const SizedBox(height: 20),

          const Text(
            "Outstanding Invoices",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          const SizedBox(height: 15),

          InvoiceTile(),
          InvoiceTile(),
          InvoiceTile(),

          const SizedBox(height: 20),

          StatementActionButton(
            icon: Icons.visibility,
            title: "View Statement",
          ),

          StatementActionButton(
            icon: Icons.picture_as_pdf,
            title: "Export PDF",
          ),

          StatementActionButton(icon: Icons.share, title: "Share Statement"),

          StatementActionButton(icon: Icons.email, title: "Send by Email"),

          StatementActionButton(
            icon: Icons.message,
            title: "Share via WhatsApp",
          ),
        ],
      ),
    );
  }
}
