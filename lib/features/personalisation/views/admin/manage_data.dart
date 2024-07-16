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

            // EXPENSES AND INCOME BUTTONS
            Center(
              child: Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 0.1,
                  ),
                  boxShadow: [
                    //
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(0, 0.5),
                      blurRadius: 0.5,
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

            // EXPENSES AND INCOME TRANSACTIONS LISTS
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isViewExpenseSelected || isViewIncomeSelected ? 550 : 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    if (isViewExpenseSelected)
                      // EXPENSES LIST
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
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              // List of all documents in expenses collection
                              List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;

                              // Organize documents by date
                              Map<String, List<DocumentSnapshot>>
                                  documentsByDate = {};
                              for (var doc in documents) {
                                Map<String, dynamic> data =
                                    doc.data() as Map<String, dynamic>;
                                Timestamp timestamp = data['date'];
                                DateTime dateTime = timestamp.toDate();
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(dateTime);

                                if (!documentsByDate
                                    .containsKey(formattedDate)) {
                                  documentsByDate[formattedDate] = [];
                                }
                                documentsByDate[formattedDate]!.add(doc);
                              }

                              // Build the list with sections
                              List<Widget> expenseTiles = [];
                              documentsByDate.forEach((date, docs) {
                                // Date header
                                expenseTiles.add(
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10.0),
                                    child: Text(
                                      date,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                );

                                // Expense tiles for the date
                                docs.forEach((doc) {
                                  Map<String, dynamic> data =
                                      doc.data() as Map<String, dynamic>;
                                  String documentId = doc.id;

                                  expenseTiles.add(
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 343,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade500,
                                              offset: const Offset(0, 0.5),
                                              blurRadius: 0.5,
                                              spreadRadius: 0.0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            buildShowDialogExpense(
                                                context, documentId);
                                          },
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['category'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 19,
                                                ),
                                              ),
                                              Text(
                                                'P${data['amount'].toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),

                                          trailing: GestureDetector(
                                            onTap: () {
                                              buildShowDialogExpense(
                                                  context, documentId);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15.0),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red.shade400,
                                              ),
                                            ),
                                          ),
                                          // Add more fields as needed
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              });

                              return ListView(
                                children: expenseTiles,
                              );
                            },
                          ),
                        ),
                      ),


                    if (isViewIncomeSelected)
                      // INCOME LIST
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
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              // List of all documents in expenses collection
                              List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;

                              // Organize documents by date
                              Map<String, List<DocumentSnapshot>>
                                  documentsByDate = {};
                              for (var doc in documents) {
                                Map<String, dynamic> data =
                                    doc.data() as Map<String, dynamic>;
                                Timestamp timestamp = data['date'];
                                DateTime dateTime = timestamp.toDate();
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(dateTime);

                                if (!documentsByDate
                                    .containsKey(formattedDate)) {
                                  documentsByDate[formattedDate] = [];
                                }
                                documentsByDate[formattedDate]!.add(doc);
                              }

                              // Build the list with sections
                              List<Widget> expenseTiles = [];
                              documentsByDate.forEach((date, docs) {
                                // Date header
                                expenseTiles.add(
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10.0),
                                    child: Text(
                                      date,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                );

                                // Expense tiles for the date
                                docs.forEach((doc) {
                                  Map<String, dynamic> data =
                                      doc.data() as Map<String, dynamic>;
                                  String documentId = doc.id;

                                  expenseTiles.add(
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 343,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade500,
                                              offset: const Offset(0, 0.5),
                                              blurRadius: 0.5,
                                              spreadRadius: 0.0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            buildShowDialogIncome(context, documentId);
                                          },
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['category'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 19,
                                                ),
                                              ),
                                              Text(
                                                'P${data['amount'].toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: GestureDetector(
                                            onTap: () {
                                              buildShowDialogIncome(context, documentId);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15.0),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red.shade400,
                                              ),
                                            ),
                                          ),
                                          // Add more fields as needed
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              });

                              return ListView(
                                children: expenseTiles,
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

  // DISPLAYS DELETE CONFIRMATION
  Future<dynamic> buildShowDialogExpense(BuildContext context, String documentId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Choose Action')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                fireStoreService.deleteExpense(documentId);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }


  // DISPLAYS DELETE CONFIRMATION
  Future<dynamic> buildShowDialogIncome(BuildContext context, String documentId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Choose Action')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                fireStoreService.deleteExpense(documentId);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
  
  
}
