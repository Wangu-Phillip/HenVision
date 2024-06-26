import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/drawer.dart';
import '../../services/firestore_service.dart';
import 'admin_dashboard.dart';
import 'manage_finances.dart';

class ManageData extends StatefulWidget {
  const ManageData({super.key});

  @override
  State<ManageData> createState() => _ManageDataState();
}

class _ManageDataState extends State<ManageData> {
  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  // buttons checker
  bool isViewExpenseSelected = true;
  bool isViewIncomeSelected = false;

  // loading checker
  bool _isLoading = false;

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Finance Transactions"),
        centerTitle: true,
      ),

      // Side bar menu
      drawer: SidebarMenu(user: user),

      // Expenses and Income Transactions
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),

            Center(
              child: Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 0.2,
                  ),
                  boxShadow: [
                    //
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(0, 2),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // View Expenses button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isViewExpenseSelected = true;
                          isViewIncomeSelected = false;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isViewExpenseSelected
                              ? const Color(0xFF6D62F7)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Expenses",
                          style: TextStyle(
                            color: isViewExpenseSelected
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    // View Incomes Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isViewExpenseSelected = false;
                          isViewIncomeSelected = true;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isViewIncomeSelected
                              ? const Color(0xFF6D62F7)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Income",
                          style: TextStyle(
                            color: isViewIncomeSelected
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            // Expenses and Income Lists
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isViewExpenseSelected || isViewIncomeSelected ? 550 : 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (isViewExpenseSelected)
                    // Expenses list
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 330,
                          height: 500,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('expenses')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              return ListView.builder(
                                itemCount: documents.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> data =
                                  documents[index].data()
                                  as Map<String, dynamic>;
                                  String documentId = documents[index].id;
                                  Timestamp timestamp = data['date'];
                                  DateTime dateTime = timestamp.toDate();
                                  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 343,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          //
                                          BoxShadow(
                                            color: Colors.grey.shade500,
                                            offset: const Offset(0, 4),
                                            blurRadius: 4.0,
                                            spreadRadius: 0.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                            'Date: $formattedDate',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                          ),
                                        ),
                                        subtitle: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text(
                                              data['category'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 19,
                                              ),
                                            ),
                                            Text(
                                                'P ${data['amount']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: GestureDetector(
                                          onTap: () {

                                            fireStoreService.deleteExpense(documentId);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red.shade500,
                                          ),
                                        ),
                                        // Add more fields as needed
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),

                    if (isViewIncomeSelected)
                    // Income list
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 330,
                          height: 500,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('income')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              return ListView.builder(
                                itemCount: documents.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> data =
                                  documents[index].data()
                                  as Map<String, dynamic>;
                                  String documentId = documents[index].id;
                                  Timestamp timestamp = data['date'];
                                  DateTime dateTime = timestamp.toDate();
                                  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 343,
                                      height: 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          //
                                          BoxShadow(
                                            color: Colors.grey.shade500,
                                            offset: const Offset(0, 4),
                                            blurRadius: 4.0,
                                            spreadRadius: 0.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          'Date: $formattedDate',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            // Category
                                            Text(
                                              data['category'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18,
                                              ),
                                            ),

                                            // Amount
                                            Text(
                                              'P ${data['amount']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),

                                        trailing: GestureDetector(
                                          onTap: () {

                                            fireStoreService.deleteIncome(documentId);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red.shade500,
                                          ),
                                        ),
                                        // Add more fields as needed
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 18.0),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF6D62F7),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const ManageFinances();
                }),
              );
            },

            child: const Icon(Icons.add),

        ),
      ),
    );
  }
}
