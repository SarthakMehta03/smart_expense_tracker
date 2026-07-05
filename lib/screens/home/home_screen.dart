import 'package:flutter/material.dart';
import 'package:smart_expense_tracker/screens/expense/add_expense_screen.dart';
import 'package:smart_expense_tracker/screens/income/income_history_screen.dart';
import '../expense/expense_list_screen.dart';
import '../analytics/analytics_screen.dart';
import '../profile/profile_screen.dart';
import 'dashboard_screen.dart';
import '../income/add_income_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const DashboardScreen(),
      const AnalyticsScreen(),
      const IncomeHistoryScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: pages[currentIndex],

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            builder: (context) {
              return SafeArea(
                child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.remove_circle_outline),
                      title: const Text("Add Expense"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddExpenseScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.add_circle_outline),
                      title: const Text("Add Income"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddIncomeScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index){
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart),label: "Analytics"),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_rounded), label: "Income",),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile")
          ]),
    );
  }
}
