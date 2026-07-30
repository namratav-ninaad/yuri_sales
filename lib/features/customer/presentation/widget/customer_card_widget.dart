import 'package:flutter/material.dart';

class CustomerCardWidget extends StatelessWidget {
  const CustomerCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("John Trading LLC"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            Text("Dubai, UAE"),

            SizedBox(height:5),

            Text("Customer Code : CUS-0012"),
          ],
        ),
      ),
    );
  }
}