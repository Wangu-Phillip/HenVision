

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {

  // get collections
  final CollectionReference expenses = FirebaseFirestore.instance.collection('expenses');

  // CREATE FINANCE DATA
    Future addExpense(double amount, String category, String description) async {
      await FirebaseFirestore.instance.collection('expenses').add({
        'amount': amount,
        'category': category,
        'date': DateTime.timestamp(),
        'description': description,
      });
    }

  Future addIncome(double amount, String category, String description) async {
    await FirebaseFirestore.instance.collection('expenses').add({
      'amount': amount,
      'category': category,
      'date': DateTime.timestamp(),
      'description': description,
    });
  }

  // READ/GET FINANCE DATA

  // CREATE OPERATIONS DATA

  // READ/GET FINANCE DATA


}