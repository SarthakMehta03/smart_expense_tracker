import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../expense/add_expense_screen.dart';
import '../expense/expense_list_screen.dart';
import '../income/add_income_screen.dart';

import '../../widgets/greeting_card.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/stats_row.dart';
import '../../widgets/analytics_chart.dart';
import '../../widgets/transaction_tile.dart';
import '../../widgets/quick_actions.dart';
import '../../widgets/section_header.dart';
import '../../widgets/empty_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('income')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, incomeSnapshot) {
        if (incomeSnapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double totalIncome = 0;

        if (incomeSnapshot.hasData) {
          for (var doc in incomeSnapshot.data!.docs) {
            totalIncome +=
                (doc['amount'] as num).toDouble();
          }
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('expenses')
              .orderBy(
            'date',
            descending: true,
          )
              .snapshots(),
          builder: (context, expenseSnapshot) {
            if (expenseSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!expenseSnapshot.hasData) {
              return const Center(
                child: Text("No Data"),
              );
            }

            double totalExpense = 0;

            for (var doc in expenseSnapshot.data!.docs) {
              totalExpense +=
                  (doc['amount'] as num).toDouble();
            }

            final savings = totalIncome - totalExpense;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  /// Greeting
                  GreetingCard(
                    userName: FirebaseAuth
                        .instance.currentUser?.email
                        ?.split('@')
                        .first ??
                        "User",
                  ),

                  const SizedBox(height: 20),

                  /// Balance
                  SummaryCard(
                    balance: savings,
                  ),

                  const SizedBox(height: 20),

                  /// Statistics
                  StatsRow(
                    income: totalIncome,
                    expense: totalExpense,
                  ),

                  const SizedBox(height: 25),

                  /// Quick Actions
                  QuickActions(
                    onExpense: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const AddExpenseScreen(),
                        ),
                      );
                    },
                    onIncome: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const AddIncomeScreen(),
                        ),
                      );
                    },
                    onAnalytics: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Open Analytics from the bottom navigation."),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  /// Chart
                  AnalyticsChart(
                    income: totalIncome,
                    expense: totalExpense,
                  ),

                  const SizedBox(height: 30),

                  /// Recent Transactions Header
                  SectionHeader(
                    title: "Recent Transactions",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ExpenseListScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  /// Empty State
                  if (expenseSnapshot.data!.docs.isEmpty)
                    const EmptyState(),

                  /// Transactions
                  if (expenseSnapshot.data!.docs.isNotEmpty)
                    ...expenseSnapshot.data!.docs
                        .take(5)
                        .map(
                          (expense) => TransactionTile(
                        title: expense['title'],
                        category: expense['category'],
                        amount: (expense['amount']
                        as num)
                            .toDouble(),
                        date: (expense['date']
                        as Timestamp)
                            .toDate(),
                      ),
                    ),

                  const SizedBox(height: 100),
                ],
              ),
            );
          },
        );
      },
    );
  }
}