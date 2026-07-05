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

  //update expense
Future<void> updateExpense({
  required String docId,
  required String title,
  required double amount,
  required String category,
  required DateTime date,
}) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
     await _firestore
    .collection('users')
    .doc(uid)
    .collection('expenses')
    .doc(docId)
    .update({
       'title': title,
       'amount': amount,
       'category': category,
       'date': Timestamp.fromDate(date),
     });

}

Future<void> deleteExpense(String docId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await _firestore
    .collection('users')
    .doc(uid)
    .collection('expenses')
    .doc(docId)
    .delete();
}

//Income

Future<void> addIncome({
  required String title,
  required double amount,
  required String source,
  required DateTime date,
}) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _firestore
    .collection('users')
    .doc(uid)
    .collection('income')
    .add({
      'title': title,
      'amount': amount,
      'source': source,
      'date': Timestamp.fromDate(date),
    });
}

  Future<void> updateIncome({
    required String docId,
    required String title,
    required double amount,
    required String source,
    required DateTime date,
}) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _firestore
    .collection('users')
    .doc(uid)
    .collection("income")
    .doc(docId)
    .update({
      'title': title,
      'amount': amount,
      'source': source,
      'date': Timestamp.fromDate(date),
    });
  }

  Future<void> deleteIncome(String id) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _firestore
    .collection('users')
    .doc(uid)
    .collection('income')
    .doc(id)
    .delete();
  }

  Stream<QuerySnapshot> getIncome() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('income')
        .orderBy('date', descending: true)
        .snapshots();
  }

}