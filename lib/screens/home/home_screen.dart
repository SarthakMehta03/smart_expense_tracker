import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  
  final List<Widget> pages = [
    const Center(child:  Text("Home Screen",style: TextStyle(fontSize: 24),)),
    const Center(child:  Text("Analytics Screen",style: TextStyle(fontSize: 24),)),
    const Center(child:  Text("Profile",style: TextStyle(fontSize: 24),)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Expense Tracker"),
      ),
      body: pages[currentIndex],
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
