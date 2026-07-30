import 'package:flutter/material.dart';

class InvoiceTile extends StatelessWidget {
  const InvoiceTile({super.key});

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.only(bottom:12),
      child: ListTile(

        title: Text("INV-1005"),

        subtitle: Text("10 Apr 2026"),

        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [

            Expanded(
              child: Text(
                "AED 2,500",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height:4),

            Expanded(
              child: Chip(
                label: Text("Pending"),
                padding: EdgeInsets.only(bottom: 5),
              ),
            )
          ],
        ),
      ),
    );
  }
}