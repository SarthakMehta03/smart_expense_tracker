import 'package:flutter/material.dart';

class AnalyticsChart extends StatelessWidget {
  final double income;
  final double expense;

  const AnalyticsChart({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final double savings = income - expense;

    final double maxValue =
    [income, expense, savings].reduce(
          (a, b) => a > b ? a : b,
    );

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Text(
              "Income vs Expense",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            _buildBar(
              title: "Income",
              value: income,
              max: maxValue,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            _buildBar(
              title: "Expense",
              value: expense,
              max: maxValue,
              color: Colors.red,
            ),

            const SizedBox(height: 20),

            _buildBar(
              title: "Savings",
              value: savings,
              max: maxValue,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar({
    required String title,
    required double value,
    required double max,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "₹${value.toStringAsFixed(0)}",
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius:
          BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: max == 0 ? 0 : value / max,
            minHeight: 14,
            backgroundColor:
            Colors.grey.shade300,
            valueColor:
            AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}