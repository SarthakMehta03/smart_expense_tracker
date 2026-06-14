import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider =
    Provider.of<ThemeProvider>(context);

    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('expenses')
          .snapshots(),
      builder: (context, snapshot) {
        int expenseCount = 0;

        if (snapshot.hasData) {
          expenseCount =
              snapshot.data!.docs.length;
        }

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                user.email ?? "No Email",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.receipt_long,
                ),
                title: const Text(
                  "Total Expenses",
                ),
                trailing: Text(
                  expenseCount.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: SwitchListTile(
                title: const Text(
                  "Dark Mode",
                ),
                secondary: const Icon(
                  Icons.dark_mode,
                ),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
                onPressed: () async {
                  bool? confirm =
                  await showDialog(
                    context: context,
                    builder: (context) =>
                        AlertDialog(
                          title:
                          const Text("Logout"),
                          content: const Text(
                            "Are you sure you want to logout?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  false,
                                );
                              },
                              child:
                              const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  true,
                                );
                              },
                              child:
                              const Text("Logout"),
                            ),
                          ],
                        ),
                  );

                  if (confirm == true) {
                    await logout(context);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}