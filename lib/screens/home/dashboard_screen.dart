import 'package:flutter/material.dart';

import '../../widgets/greeting_card.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/stats_row.dart';
import '../../widgets/transaction_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          const GreetingCard(),

          const SizedBox(height: 20),

          const SummaryCard(
            balance: 25000,
          ),

          const SizedBox(height: 20),

          const StatsRow(
            income: 30000,
            expense: 5000,
          ),

          const SizedBox(height: 30),

          const Text(
            "Recent Transactions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          TransactionTile(
            title: "Netflix",
            category: "Entertainment",
            amount: 499,
            date: DateTime.now(),
          ),

          TransactionTile(
            title: "Petrol",
            category: "Travel",
            amount: 1200,
            date: DateTime.now(),
          ),

          TransactionTile(
            title: "Swiggy",
            category: "Food",
            amount: 350,
            date: DateTime.now(),
          ),
        ],
      ),
    );
  }
}