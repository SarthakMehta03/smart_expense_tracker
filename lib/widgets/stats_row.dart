import 'package:flutter/material.dart';

class StatsRow extends StatelessWidget {
  final double income;
  final double expense;

  const StatsRow({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {

    final double savings = income - expense;

    return Row(
      children: [

        Expanded(
          child: _buildStatCard(
            title: "Income",
            amount: income,
            icon: Icons.arrow_downward,
            color: Colors.green,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _buildStatCard(
            title: "Expense",
            amount: expense,
            icon: Icons.arrow_upward,
            color: Colors.red,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _buildStatCard(
            title: "Savings",
            amount: savings,
            icon: Icons.savings,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required double amount,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: color.withOpacity(0.1),

        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [
          Icon(
            icon,
            color: color,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "₹${amount.toStringAsFixed(0)}",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}