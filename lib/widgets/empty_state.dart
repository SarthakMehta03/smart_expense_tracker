import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: const [
          Icon(
            Icons.receipt_long,
            size: 80,
            color: Colors.grey,
          ),

          SizedBox(height: 20),

          Text(
            "No Transactions Yet",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "Tap + to add your first expense",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}