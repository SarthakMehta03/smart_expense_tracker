import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import 'add_income_screen.dart';

class IncomeHistoryScreen extends StatefulWidget {
  const IncomeHistoryScreen({super.key});

  @override
  State<IncomeHistoryScreen> createState() =>
      _IncomeHistoryScreenState();
}

class _IncomeHistoryScreenState
    extends State<IncomeHistoryScreen> {
  final FirestoreService firestoreService =
  FirestoreService();

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
          .collection('income')
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
              "No Income Found",
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
                  hintText:
                  "Search by title or source",
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
                  final income =
                  snapshot.data!.docs[index];

                  final title = income['title']
                      .toString()
                      .toLowerCase();

                  final source = income['source']
                      .toString()
                      .toLowerCase();

                  if (searchText.isNotEmpty &&
                      !title.contains(searchText) &&
                      !source.contains(searchText)) {
                    return const SizedBox.shrink();
                  }

                  final Timestamp timestamp =
                  income['date'] as Timestamp;

                  final DateTime date =
                  timestamp.toDate();

                  return Card(
                    margin:
                    const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor:
                        Colors.green,
                        child: Icon(
                          Icons.currency_rupee,
                          color: Colors.white,
                        ),
                      ),

                      title: Text(
                        income['title'],
                        style: const TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        "${income['source']} • "
                            "${date.day}/${date.month}/${date.year}",
                      ),

                      trailing: Row(
                        mainAxisSize:
                        MainAxisSize.min,
                        children: [
                          Text(
                            "₹${income['amount']}",
                            style:
                            const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color: Colors.green,
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
                                  builder:
                                      (context) =>
                                      AddIncomeScreen(
                                        docId:
                                        income.id,
                                        title: income[
                                        'title'],
                                        amount: (income[
                                        'amount']
                                        as num)
                                            .toDouble(),
                                        source: income[
                                        'source'],
                                        date: (income[
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
                            onPressed:
                                () async {
                              bool? confirm =
                              await showDialog(
                                context:
                                context,
                                builder:
                                    (context) =>
                                    AlertDialog(
                                      title:
                                      const Text(
                                        "Delete Income",
                                      ),
                                      content:
                                      const Text(
                                        "Are you sure you want to delete this income?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () {
                                            Navigator.pop(
                                              context,
                                              false,
                                            );
                                          },
                                          child:
                                          const Text(
                                            "Cancel",
                                          ),
                                        ),
                                        TextButton(
                                          onPressed:
                                              () {
                                            Navigator.pop(
                                              context,
                                              true,
                                            );
                                          },
                                          child:
                                          const Text(
                                            "Delete",
                                          ),
                                        ),
                                      ],
                                    ),
                              );

                              if (confirm ==
                                  true) {
                                await firestoreService
                                    .deleteIncome(
                                  income.id,
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