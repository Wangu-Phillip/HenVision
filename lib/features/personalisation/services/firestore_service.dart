

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

    // REMOVE EXPENSES
    Future<void> deleteExpense(String expenseId) async {
      try {
        await FirebaseFirestore.instance.collection('expenses').doc(expenseId).delete();
        print('Expense deleted successfully');
      } catch (e) {
        print('Error deleting expense: $e');
      }
    }


    // REMOVE INCOME
    Future<void> deleteIncome(String documentId) async {
      try {
        await FirebaseFirestore.instance.collection('income').doc(documentId).delete();
        print('Income deleted successfully');
      } catch (e) {
        print('Error deleting income: $e');
      }
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

    // GET INCOME CATEGORY AMOUNTS
    Future<double> getTotalEggSalesAmount() async {
      final firestore = FirebaseFirestore.instance;
      final incomeRef = firestore.collection('income');
      final snapshot = await incomeRef.where('category', isEqualTo: 'Egg Sales').get();

      double total = 0;
      snapshot.docs.forEach((doc) {
        final amount = doc['amount'] as double?;
        if (amount != null) {
          total += amount;
        }
      });

      return total;
    }

    Future<double> getTotalMeatSalesAmount() async {
      final firestore = FirebaseFirestore.instance;
      final incomeRef = firestore.collection('income');
      final snapshot = await incomeRef.where('category', isEqualTo: 'Meat Sales').get();

      double total = 0;
      snapshot.docs.forEach((doc) {
        final amount = doc['amount'] as double?;
        if (amount != null) {
          total += amount;
        }
      });

      return total;
    }

    Future<double> getTotalFeatherSalesAmount() async {
      final firestore = FirebaseFirestore.instance;
      final incomeRef = firestore.collection('income');
      final snapshot = await incomeRef.where('category', isEqualTo: 'Feather Sales').get();

      double total = 0;
      snapshot.docs.forEach((doc) {
        final amount = doc['amount'] as double?;
        if (amount != null) {
          total += amount;
        }
      });

      return total;
    }

    Future<double> getTotalFertilizerSalesAmount() async {
      final firestore = FirebaseFirestore.instance;
      final incomeRef = firestore.collection('income');
      final snapshot = await incomeRef.where('category', isEqualTo: 'Fertilizer Sales').get();

      double total = 0;
      snapshot.docs.forEach((doc) {
        final amount = doc['amount'] as double?;
        if (amount != null) {
          total += amount;
        }
      });

      return total;
    }

    Future<double> getTotalChickenSalesAmount() async {
      final firestore = FirebaseFirestore.instance;
      final incomeRef = firestore.collection('income');
      final snapshot = await incomeRef.where('category', isEqualTo: 'Meat Sales').get();

      double total = 0;
      snapshot.docs.forEach((doc) {
        final amount = doc['amount'] as double?;
        if (amount != null) {
          total += amount;
        }
      });

      return total;
    }

    // GET INCOME CATEGORY AMOUNTS
    Future<double> getTotalFeedCosts() async {
      final firestore = FirebaseFirestore.instance;
      final incomeRef = firestore.collection('expenses');
      final snapshot = await incomeRef.where('category', isEqualTo: 'Feed Costs').get();

      double total = 0;
      snapshot.docs.forEach((doc) {
        final amount = doc['amount'] as double?;
        if (amount != null) {
          total += amount;
        }
      });

      return total;
    }


    Future<double> getTotalLaborCosts() async {
      final firestore = FirebaseFirestore.instance;
      final incomeRef = firestore.collection('expenses');
      final snapshot = await incomeRef.where('category', isEqualTo: 'Labor Costs').get();

      double total = 0;
      snapshot.docs.forEach((doc) {
        final amount = doc['amount'] as double?;
        if (amount != null) {
          total += amount;
        }
      });

      return total;
    }

    Future<double> getTotalUtilityCosts() async {
      final firestore = FirebaseFirestore.instance;
      final incomeRef = firestore.collection('expenses');
      final snapshot = await incomeRef.where('category', isEqualTo: 'Utilities').get();

      double total = 0;
      snapshot.docs.forEach((doc) {
        final amount = doc['amount'] as double?;
        if (amount != null) {
          total += amount;
        }
      });

      return total;
    }

    Future<double> getTotalVeterinaryCosts() async {
      final firestore = FirebaseFirestore.instance;
      final incomeRef = firestore.collection('expenses');
      final snapshot = await incomeRef.where('category', isEqualTo: 'Veterinary Care').get();

      double total = 0;
      snapshot.docs.forEach((doc) {
        final amount = doc['amount'] as double?;
        if (amount != null) {
          total += amount;
        }
      });

      return total;
    }

    Future<double> getTotalEquipmentSupplies() async {
      final firestore = FirebaseFirestore.instance;
      final incomeRef = firestore.collection('expenses');
      final snapshot = await incomeRef.where('category', isEqualTo: 'Equipment & Supplies').get();

      double total = 0;
      snapshot.docs.forEach((doc) {
        final amount = doc['amount'] as double?;
        if (amount != null) {
          total += amount;
        }
      });

      return total;
    }


}