import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'expense_pie_chart.dart';
import 'monthly_bar_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('expenses')
        .snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child : CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Expenses Found"),
            );
          }

          double food = 0;
          double travel = 0;
          double shopping = 0;
          double bills = 0;
          double others = 0;
          double totalExpense = 0;
          double monthlyExpense = 0;
          double todayExpense = 0;

          DateTime now = DateTime.now();

          List<double> monthlyData =
          List.generate(12, (_) => 0);

          for (var doc in snapshot.data!.docs){

            double amount = (doc['amount'] as num).toDouble();
            DateTime date = (doc['date'] as Timestamp).toDate();
            String category = doc['category'];

            monthlyData[date.month - 1] += amount;

            switch (category) {
              case 'Food':
                food += amount;
                break;

              case 'Travel':
                travel += amount;
                break;

              case 'Shopping':
                shopping += amount;
                break;

              case 'Bills':
                bills += amount;
                break;

              default:
                others += amount;
            }
            totalExpense += amount;

            if(date.month == now.month && date.year == now.year){
              monthlyExpense += amount;
            }
            if(date.day == now.day && date.month == now.month && date.year == now.year){
              todayExpense += amount;
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                buildCard(
                  title : "Total Expenses",
                  amount : totalExpense,
                  icon: Icons.account_balance_wallet
                ),

                const SizedBox(height: 15,),

                buildCard(
                    title : "Monthly Expenses",
                    amount : monthlyExpense,
                    icon: Icons.calendar_month
                ),

                const SizedBox(height: 15,),

                buildCard(
                    title : "Today Expenses",
                    amount : todayExpense,
                    icon: Icons.today
                ),

                const SizedBox(height: 20),

                const Text(
                  "Expense Distribution",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ExpensePieChart(
                  food: food,
                  travel: travel,
                  shopping: shopping,
                  bills: bills,
                  others: others,
                ),

                const SizedBox(height: 30),

                const Text(
                  "Monthly Spending",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                MonthlyBarChart(
                  monthlyData: monthlyData,
                ),
              ],
            ),
          );


        });
  }
  Widget buildCard({
    required String title,
    required double amount,
    required IconData icon,
 }){
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon,size: 35,),
        title: Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(
          '₹${amount.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 18),),
      ),

    );

  }
}
