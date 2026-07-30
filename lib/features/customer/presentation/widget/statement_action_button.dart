import 'package:flutter/material.dart';

class StatementActionButton extends StatelessWidget {

  final IconData icon;
  final String title;

  const StatementActionButton({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom:12),
      child: SizedBox(
        width: double.infinity,
        height:50,
        child: OutlinedButton.icon(
          icon: Icon(icon),
          label: Text(title),
          onPressed: (){},
        ),
      ),
    );
  }
}