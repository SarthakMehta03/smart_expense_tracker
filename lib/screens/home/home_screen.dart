import 'package:flutter/material.dart';
import 'package:smart_expense_tracker/screens/expense/add_expense_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../expense/expense_list_screen.dart';
import '../analytics/analytics_screen.dart';

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
      const ExpenseListScreen(),
      const AnalyticsScreen(),
      const Center(child:  Text("Profile",style: TextStyle(fontSize: 24),)),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Expense Tracker"),
      ),
      body: pages[currentIndex],

      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> const AddExpenseScreen()));
          },
        child: const Icon(Icons.add),
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
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile")
          ]),
    );
  }
}
