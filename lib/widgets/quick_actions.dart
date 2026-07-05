import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onExpense;
  final VoidCallback onIncome;
  final VoidCallback onAnalytics;

  const QuickActions({
    super.key,
    required this.onExpense,
    required this.onIncome,
    required this.onAnalytics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: _actionCard(
                icon: Icons.remove_circle_outline,
                title: "Expense",
                color: Colors.red,
                onTap: onExpense,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _actionCard(
                icon: Icons.add_circle_outline,
                title: "Income",
                color: Colors.green,
                onTap: onIncome,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _actionCard(
                icon: Icons.bar_chart,
                title: "Reports",
                color: Colors.indigo,
                onTap: onAnalytics,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(.08),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}