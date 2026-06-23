import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String category;
  final double amount;
  final DateTime date;

  const TransactionTile({
    super.key,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            title[0].toUpperCase(),
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          "$category • ${date.day}/${date.month}/${date.year}",
        ),

        trailing: Text(
          "₹${amount.toStringAsFixed(0)}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}