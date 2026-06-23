import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/greeting_card.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/stats_row.dart';
import '../../widgets/transaction_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('expenses')
          .orderBy(
        'date',
        descending: true,
      )
          .snapshots(),

      builder: (context, snapshot) {

        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text("No Data"),
          );
        }

        double totalExpense = 0;

        for (var doc in snapshot.data!.docs) {
          totalExpense +=
              (doc['amount'] as num)
                  .toDouble();
        }

        double income = 30000;

        double savings =
            income - totalExpense;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              GreetingCard(
                userName:
                FirebaseAuth
                    .instance
                    .currentUser
                    ?.email ??
                    "User",
              ),

              const SizedBox(height: 20),

              SummaryCard(
                balance: savings,
              ),

              const SizedBox(height: 20),

              StatsRow(
                income: income,
                expense: totalExpense,
              ),

              const SizedBox(height: 30),

              const Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              if (snapshot.data!.docs.isEmpty)
                const Center(
                  child: Padding(
                    padding:
                    EdgeInsets.all(20),
                    child: Text(
                      "No Expenses Found",
                    ),
                  ),
                ),

              ...snapshot.data!.docs
                  .take(5)
                  .map((expense) {

                return TransactionTile(
                  title:
                  expense['title'],

                  category:
                  expense['category'],

                  amount:
                  (expense['amount']
                  as num)
                      .toDouble(),

                  date:
                  (expense['date']
                  as Timestamp)
                      .toDate(),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}