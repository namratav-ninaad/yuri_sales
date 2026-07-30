import 'package:flutter/material.dart';

class FinancialSummaryCard extends StatelessWidget {
  const FinancialSummaryCard({super.key});

  Widget item(String title,String value){

    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(title),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            item("Outstanding","AED 12,450"),

            Divider(),

            item("Not Due","AED 5,200"),

            Divider(),

            item("Overdue","AED 7,250"),

            Divider(),

            item("Credit Limit","AED 50,000"),

            Divider(),

            item("Available Credit","AED 37,550"),
          ],
        ),
      ),
    );
  }
}