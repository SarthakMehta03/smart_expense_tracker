import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
    required DateTime date,
}) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await _firestore.collection('users').doc(uid).collection('expenses').add({
      'title':title,
      'amount':amount,
      'category':category,
      'date':Timestamp.fromDate(date),
      'createdAt':FieldValue.serverTimestamp(),
    });
  }
}