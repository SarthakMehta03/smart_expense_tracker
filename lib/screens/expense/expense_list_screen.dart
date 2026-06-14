import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_expense_screen.dart';
import '../../services/firestore_service.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController searchController =
  TextEditingController();

  String searchText = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('expenses')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "No Expenses Found",
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: "Search by title or category",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText =
                        value.trim().toLowerCase();
                  });
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final expense =
                  snapshot.data!.docs[index];

                  final title = expense['title']
                      .toString()
                      .toLowerCase();

                  final category = expense['category']
                      .toString()
                      .toLowerCase();

                  if (searchText.isNotEmpty &&
                      !title.contains(searchText) &&
                      !category.contains(searchText)) {
                    return const SizedBox.shrink();
                  }

                  final Timestamp timestamp =
                  expense['date'] as Timestamp;

                  final DateTime date =
                  timestamp.toDate();

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      title: Text(
                        expense['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        "${expense['category']} • "
                            "${date.day}/${date.month}/${date.year}",
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "₹${expense['amount']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddExpenseScreen(
                                        docId: expense.id,
                                        title:
                                        expense['title'],
                                        amount: (expense[
                                        'amount']
                                        as num)
                                            .toDouble(),
                                        category: expense[
                                        'category'],
                                        date: (expense[
                                        'date']
                                        as Timestamp)
                                            .toDate(),
                                      ),
                                ),
                              );
                            },
                          ),

                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              bool? confirm =
                              await showDialog(
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                      title: const Text(
                                        "Delete Expense",
                                      ),
                                      content: const Text(
                                        "Are you sure you want to delete this expense?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                              context,
                                              false,
                                            );
                                          },
                                          child: const Text(
                                            "Cancel",
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                              context,
                                              true,
                                            );
                                          },
                                          child: const Text(
                                            "Delete",
                                          ),
                                        ),
                                      ],
                                    ),
                              );

                              if (confirm == true) {
                                await firestoreService
                                    .deleteExpense(
                                  expense.id,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}