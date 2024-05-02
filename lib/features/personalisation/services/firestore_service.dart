

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FireStoreService {

  /// This method is used to add an expense to the Firestore database.
  ///
  /// @param amount The amount of the expense. This should be a double value.
  /// @param category The category of the expense. This should be a string value.
  /// @param description The description of the expense. This should be a string value.
  ///
  /// @return A Future that completes when the operation finishes. The Future will be
  /// completed with an error if the operation fails.
  ///
  /// The method works by first getting a reference to the Firestore instance and then
  /// accessing the 'expenses' collection.
  /// It then adds a new document to this collection with the provided amount, category, and description.
  /// The date of the expense is set to the current timestamp.
    Future addExpense(double amount, String category, String description) async {
      await FirebaseFirestore.instance.collection('expenses').add({
        'amount': amount,
        'category': category,
        'date': DateTime.timestamp(),
        'description': description,
      });
    }

    /// This method is used to add an income to the Firestore database.
    ///
    /// @param amount The amount of the income. This should be a double value.
    /// @param category The category of the income. This should be a string value.
    /// @param description The description of the income. This should be a string value.
    ///
    /// @return A Future that completes when the operation finishes. The Future will be
    /// completed with an error if the operation fails.
    ///
    /// The method works by first getting a reference to the Firestore instance and
    /// then accessing the 'income' collection.
    /// It then adds a new document to this collection with the provided amount, category, and description.
    /// The date of the income is set to the current timestamp.
  Future addIncome(double amount, String category, String description) async {
    await FirebaseFirestore.instance.collection('income').add({
      'amount': amount,
      'category': category,
      'date': DateTime.timestamp(),
      'description': description,
    });
  }


    /// This method is used to calculate the total income from the Firestore database.
    ///
    /// @return A Future that completes with the total income as a double. The Future will be completed with an error if the operation fails.
    ///
    /// The method works by first getting a reference to the Firestore instance and then accessing the 'income' collection.
    /// It then retrieves all documents from this collection and maps each document to its 'amount' field, which is cast to a num.
    /// If the 'amount' field is null, it defaults to 0.0.
    /// The method then reduces the mapped amounts to a single value by adding them up, starting from 0.0.
    Future<double> getTotalIncome() async {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('income').get();
      double totalIncome = snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>?)?['amount'] as num? ?? 0.0)
          .fold(0.0, (prev, amount) => prev + (amount ?? 0.0));
      return totalIncome;
    }

    /// This method is used to calculate the total expenses from the Firestore database.
    ///
    /// @return A Future that completes with the total expenses as a double.
    /// The Future will be completed with an error if the operation fails.
    ///
    /// The method works by first getting a reference to the Firestore instance and
    /// then accessing the 'expenses' collection.
    /// It then retrieves all documents from this collection and maps each document
    /// to its 'amount' field, which is cast to a num.
    /// If the 'amount' field is null, it defaults to 0.0.
    /// The method then reduces the mapped amounts to a single value by adding them up, starting from 0.0.
    Future<double> getTotalExpenses() async {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('expenses').get();
      double totalExpenses = snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>?)?['amount'] as num? ?? 0.0)
          .fold(0.0, (prev, amount) => prev + (amount ?? 0.0));
      return totalExpenses;
    }

    /// This method is used to delete an expense from the Firestore database.
    ///
    /// @param expenseId The ID of the expense to be deleted. This should be a string value.
    ///
    /// @return A Future that completes when the operation finishes. The Future will be completed with an error if the operation fails.
    ///
    /// The method works by first getting a reference to the Firestore instance and then accessing the 'expenses' collection.
    /// It then deletes the document with the provided ID from this collection.
    /// If the operation is successful, it prints a success message. If it fails, it prints an error message.
    Future<void> deleteExpense(String expenseId) async {
      try {
        await FirebaseFirestore.instance.collection('expenses').doc(expenseId).delete();
        print('Expense deleted successfully');
      } catch (e) {
        print('Error deleting expense: $e');
      }
    }


    /// Deletes an income record from the Firestore database.
    ///
    /// This method deletes a document from the 'income' collection in Firestore.
    /// The document to be deleted is identified by the provided [documentId].
    ///
    /// If the operation is successful, it prints a success message.
    /// If the operation fails, it prints an error message.
    ///
    /// @param documentId The ID of the income document to be deleted. This should be a string value.
    ///
    /// @return A Future that completes when the operation finishes. The Future will be
    /// completed with an error if the operation fails.
    Future<void> deleteIncome(String documentId) async {
      try {
        await FirebaseFirestore.instance.collection('income').doc(documentId).delete();
        print('Income deleted successfully');
      } catch (e) {
        print('Error deleting income: $e');
      }
    }


    /// Adds a new layer record to the Firestore database.
    ///
    /// This method adds a document to the 'layers' collection in Firestore.
    /// The document contains information about the number of layers, total eggs collected,
    /// egg sizes, weight of the eggs, and a description.
    ///
    /// @param totalLayers The total number of layers. This should be an integer value.
    /// @param totalEggsCollected The total number of eggs collected. This should be an integer value.
    /// @param eggSizes The sizes of the eggs. This should be a string value.
    /// @param eggsWeight The total weight of the eggs. This should be a double value.
    /// @param description A description of the layer record. This should be a string value.
    ///
    /// @return A Future that completes when the operation finishes. The Future will be
    /// completed with an error if the operation fails.
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

    /// Adds a new broiler record to the Firestore database.
    ///
    /// This method adds a document to the 'broilers' collection in Firestore.
    /// The document contains information about the total number of broilers,
    /// the number of sold broilers, the number of slaughtered broilers, and a description.
    ///
    /// @param totalBroilers The total number of broilers. This should be an integer value.
    /// @param soldBroilers The number of broilers sold. This should be an integer value.
    /// @param slaughteredBroilers The number of broilers slaughtered. This should be an integer value.
    /// @param description A description of the broiler record. This should be a string value.
    ///
    /// @return A Future that completes when the operation finishes. The Future will be
    /// completed with an error if the operation fails.
    Future addBroilers(int totalBroilers, int soldBroilers, int slaughteredBroilers, String description) async {
      await FirebaseFirestore.instance.collection('broilers').add({
        'number_of_broilers': totalBroilers,
        'sold_broilers': soldBroilers,
        'slaughtered_broilers': slaughteredBroilers,
        'date': DateTime.timestamp(),
        'description': description,
      });
    }


    /// Adds a new user to the Firestore database and Firebase Authentication.
    ///
    /// This method first creates a new user in Firebase Authentication using the provided [email] and a default password.
    /// It then gets the user's ID from the authentication result and saves the user's information to the 'users' collection in Firestore.
    ///
    /// The document contains information about the user's name, surname, role, and email.
    /// The date of the user creation is set to the current timestamp.
    ///
    /// @param name The name of the user. This should be a string value.
    /// @param surname The surname of the user. This should be a string value.
    /// @param role The role of the user. This should be a string value.
    /// @param email The email of the user. This should be a string value.
    ///
    /// @return A Future that completes when the operation finishes. The Future will be
    /// completed with an error if the operation fails.
    Future<void> addUser(String name, String surname, String role, String email) async {
      try {
        // First, create the user in Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: 'password',
        );

        // Get the user's ID from the authentication result
        String userId = userCredential.user!.uid;

        // Then, save the user's information to Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'name': name,
          'surname': surname,
          'role': role,
          'date': DateTime.timestamp(), // Use DateTime.now() instead of DateTime.timestamp()
          'email': email,
        });
      } catch (e) {
        print('Failed to create user: $e');
        // Handle the error appropriately
      }
    }

    /// Retrieves the role of a user from the Firestore database.
    /// This method is used to verify the type of user login into the system.
    /// It is also used to direct the different users to their respective dashboards.
    ///
    /// This method queries the 'users' collection in Firestore for a
    /// document where the 'email' field matches the provided [userId].
    /// It limits the query to a single document.
    ///
    /// If a matching document is found, it retrieves the 'role' field from
    /// the document and returns it as a string.
    /// If no matching document is found, it returns null.
    ///
    /// @param userId The ID of the user whose role is to be retrieved. This should be a string value.
    ///
    /// @return A Future that completes with the role of the user as a string, or
    /// null if no matching user is found.
    Future<String?> getUserRole(String userId) async {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.get('role') as String?;
      } else {
        return null;
      }
    }


    /// Edits a user's information in the Firestore database.
    ///
    /// This method updates a document in the 'users' collection in Firestore.
    /// The document to be updated is identified by the provided [userId].
    /// The fields to be updated are the user's name, surname, role, and email.
    ///
    /// If the operation is successful, it prints a success message.
    /// If the operation fails, it prints an error message.
    ///
    /// @param userId The ID of the user to be edited. This should be a string value.
    /// @param name The new name of the user. This should be a string value.
    /// @param surname The new surname of the user. This should be a string value.
    /// @param role The new role of the user. This should be a string value.
    /// @param email The new email of the user. This should be a string value.
    ///
    /// @return A Future that completes when the operation finishes. The Future will be
    /// completed with an error if the operation fails.
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


    /// Deletes a user from the Firestore database.
    ///
    /// This method queries the 'users' collection in Firestore for a document where the 'email' field matches the provided [email].
    /// It then deletes each matching document from the 'users' collection.
    ///
    /// If the operation is successful, it prints a success message.
    /// If the operation fails, it prints an error message.
    ///
    /// @param email The email of the user to be deleted. This should be a string value.
    ///
    /// @return A Future that completes when the operation finishes. The Future will be
    /// completed with an error if the operation fails.
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


    /// Adds a new budget record to the Firestore database.
    ///
    /// This method adds a document to the 'budget' collection in Firestore.
    /// The document contains information about the budget amount.
    ///
    /// @param amount The amount of the budget. This should be a double value.
    ///
    /// @return A Future that completes when the operation finishes. The Future will be
    /// completed with an error if the operation fails.
    Future addBudget(double amount) async {
      await FirebaseFirestore.instance.collection('budget').add({
        'amount': amount,
      });
    }


    /// Retrieves the most recent budget amount from the Firestore database.
    ///
    /// This method queries the 'budget' collection in Firestore for all documents,
    /// orders them by the 'date' field in descending order, and limits the query to the most recent document.
    ///
    /// If a document is found, it retrieves the 'amount' field from the document and returns it as a double.
    /// If no document is found, it returns null.
    ///
    /// @return A Future that completes with the most recent budget amount as a double, or
    /// null if no budget document is found.
    Future<double?> getRecentBudgetAmount() async {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('budget').orderBy('date', descending: true).limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.get('amount') as double?;
      } else {
        return null;
      }
    }


    /// Retrieves the total amount of egg sales from the Firestore database.
    ///
    /// This method queries the 'income' collection in Firestore for all documents,
    /// where the 'category' field matches 'Egg Sales'.
    ///
    /// It then iterates over each matching document, retrieves the 'amount' field from
    /// the document, and adds it to a running total.
    ///
    /// If the 'amount' field is null, it is ignored.
    ///
    /// @return A Future that completes with the total amount of egg sales as a double.
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


    /// Retrieves the total amount of meat sales from the Firestore database.
    ///
    /// This method queries the 'income' collection in Firestore for all documents,
    /// where the 'category' field matches 'Meat Sales'.
    ///
    /// It then iterates over each matching document, retrieves the 'amount' field from
    /// the document, and adds it to a running total.
    ///
    /// If the 'amount' field is null, it is ignored.
    ///
    /// @return A Future that completes with the total amount of meat sales as a double.
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


    /// Retrieves the total amount of feather sales from the Firestore database.
    ///
    /// This method queries the 'income' collection in Firestore for all documents,
    /// where the 'category' field matches 'Feather Sales'.
    ///
    /// It then iterates over each matching document, retrieves the 'amount' field from
    /// the document, and adds it to a running total.
    ///
    /// If the 'amount' field is null, it is ignored.
    ///
    /// @return A Future that completes with the total amount of feather sales as a double.
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


    /// Retrieves the total amount of fertilizer sales from the Firestore database.
    ///
    /// This method queries the 'income' collection in Firestore for all documents,
    /// where the 'category' field matches 'Fertilizer Sales'.
    ///
    /// It then iterates over each matching document, retrieves the 'amount' field from
    /// the document, and adds it to a running total.
    ///
    /// If the 'amount' field is null, it is ignored.
    ///
    /// @return A Future that completes with the total amount of fertilizer sales as a double.
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

    /// Retrieves the total amount of chicken sales from the Firestore database.
    ///
    /// This method queries the 'income' collection in Firestore for all documents,
    /// where the 'category' field matches 'Chicken Sales'.
    ///
    /// It then iterates over each matching document, retrieves the 'amount' field from
    /// the document, and adds it to a running total.
    ///
    /// If the 'amount' field is null, it is ignored.
    ///
    /// @return A Future that completes with the total amount of chicken sales as a double.
    Future<double> getTotalChickenSalesAmount() async {
      final firestore = FirebaseFirestore.instance;
      final incomeRef = firestore.collection('income');
      final snapshot = await incomeRef.where('category', isEqualTo: 'Chicken Sales').get();

      double total = 0;
      snapshot.docs.forEach((doc) {
        final amount = doc['amount'] as double?;
        if (amount != null) {
          total += amount;
        }
      });

      return total;
    }


    /// Retrieves the total amount of feed costs from the Firestore database.
    ///
    /// This method queries the 'expenses' collection in Firestore for all documents,
    /// where the 'category' field matches 'Feed Costs'.
    ///
    /// It then iterates over each matching document, retrieves the 'amount' field from
    /// the document, and adds it to a running total.
    ///
    /// If the 'amount' field is null, it is ignored.
    ///
    /// @return A Future that completes with the total amount of feed costs as a double.
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


    /// Retrieves the total amount of labor costs from the Firestore database.
    ///
    /// This method queries the 'expenses' collection in Firestore for all documents,
    /// where the 'category' field matches 'Labor Costs'.
    ///
    /// It then iterates over each matching document, retrieves the 'amount' field from
    /// the document, and adds it to a running total.
    ///
    /// If the 'amount' field is null, it is ignored.
    ///
    /// @return A Future that completes with the total amount of labor costs as a double.
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

    /// Retrieves the total amount of utility costs from the Firestore database.
    ///
    /// This method queries the 'expenses' collection in Firestore for all documents,
    /// where the 'category' field matches 'Utilities'.
    ///
    /// It then iterates over each matching document, retrieves the 'amount' field from
    /// the document, and adds it to a running total.
    ///
    /// If the 'amount' field is null, it is ignored.
    ///
    /// @return A Future that completes with the total amount of utility costs as a double.
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


    /// Retrieves the total amount of veterinary costs from the Firestore database.
    ///
    /// This method queries the 'expenses' collection in Firestore for all documents,
    /// where the 'category' field matches 'Veterinary Care'.
    ///
    /// It then iterates over each matching document, retrieves the 'amount' field from
    /// the document, and adds it to a running total.
    ///
    /// If the 'amount' field is null, it is ignored.
    ///
    /// @return A Future that completes with the total amount of veterinary costs as a double.
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


    /// Retrieves the total amount of equipment and supplies costs from the Firestore database.
    ///
    /// This method queries the 'expenses' collection in Firestore for all documents,
    /// where the 'category' field matches 'Equipment & Supplies'.
    ///
    /// It then iterates over each matching document, retrieves the 'amount' field from
    /// the document, and adds it to a running total.
    ///
    /// If the 'amount' field is null, it is ignored.
    ///
    /// @return A Future that completes with the total amount of equipment and supplies costs as a double.
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