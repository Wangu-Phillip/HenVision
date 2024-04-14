

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {

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
    await FirebaseFirestore.instance.collection('income').add({
      'amount': amount,
      'category': category,
      'date': DateTime.timestamp(),
      'description': description,
    });
  }

  // READ/GET FINANCE DATA
    Future<double> getTotalIncome() async {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('income').get();
      double totalIncome = snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>?)?['amount'] as num? ?? 0.0)
          .fold(0.0, (prev, amount) => prev + (amount ?? 0.0));
      return totalIncome;
    }

    Future<double> getTotalExpenses() async {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('expenses').get();
      double totalExpenses = snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>?)?['amount'] as num? ?? 0.0)
          .fold(0.0, (prev, amount) => prev + (amount ?? 0.0));
      return totalExpenses;
    }

    // CREATE OPERATIONS DATA
    Future addLayers(int totalLayers, int totalEggsCollected, String eggSizes, double eggsWeight, String description) async {
      await FirebaseFirestore.instance.collection('layers').add({
        'number_of_layers': totalLayers,
        'eggs_collected': totalEggsCollected,
        'egg_sizes': eggSizes,
        'eggs_weight': eggsWeight,
        'date': DateTime.timestamp(),
        'description': description,
      });
    }

    Future addBroilers(int totalBroilers, int soldBroilers, int slaughteredBroilers, String description) async {
      await FirebaseFirestore.instance.collection('broilers').add({
        'number_of_broilers': totalBroilers,
        'sold_broilers': soldBroilers,
        'slaughtered_broilers': slaughteredBroilers,
        'date': DateTime.timestamp(),
        'description': description,
      });
    }

  // READ/GET OPERATIONS DATA

  /// TODO: Add users
  // CREATE USER
    Future addUser(String name, String surname, String role, String email) async {
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'surname': surname,
        'role': role,
        'date': DateTime.timestamp(),
        'email': email,
      });
    }

    /// TODO: Get users

  /// TODO: Edit users
    // EDIT USER
    Future<void> editUser(String userId, String name, String surname, String role, String email) async {
      try {
        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'name': name,
          'surname': surname,
          'role': role,
          'email': email,
        });
        print('User edited successfully');
      } catch (e) {
        print('Error editing user: $e');
      }
    }

    /// TODO: Delete users
    // REMOVE USER
    Future<void> deleteUser(String email) async {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        querySnapshot.docs.forEach((doc) async {
          await FirebaseFirestore.instance.collection('users').doc(doc.id).delete();
        });

        print('User deleted successfully');
      } catch (e) {
        print('Error deleting user: $e');
      }
    }


    // CREATE OR ADD NEW BUDGET
    Future addBudget(double amount) async {
      await FirebaseFirestore.instance.collection('budget').add({
        'amount': amount,
      });
    }

  // READ OR GET BUDGET
    Future<double?> getRecentBudgetAmount() async {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('budget').orderBy('date', descending: true).limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.get('amount') as double?;
      } else {
        return null;
      }
    }



}