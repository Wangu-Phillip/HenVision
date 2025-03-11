import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/common/widgets/drawer.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_data.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_finances.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_operations.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_users.dart';
import 'package:hen_vision/features/personalisation/views/finance_analytics.dart';
import 'package:hen_vision/features/personalisation/views/calendar.dart';
import 'package:hen_vision/features/personalisation/views/file_upload.dart';
import 'package:hen_vision/features/personalisation/views/generate_pdf.dart';
import 'package:hen_vision/features/personalisation/views/reports.dart';
import 'package:hen_vision/features/personalisation/views/user/farmer_add_data.dart';
import 'package:hen_vision/features/personalisation/views/user/farmer_add_operations.dart';
import 'package:hen_vision/utils/charts/Percentage_Indicator.dart';
import 'package:hen_vision/utils/charts/line_chart.dart';
import 'package:hen_vision/utils/charts/pie_chart.dart';

import '../../../../common/widgets/farmers_drawer.dart';
import '../../services/firestore_service.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  State<FarmerDashboard> createState() => _FarmerDashboard();
}

class _FarmerDashboard extends State<FarmerDashboard> {
  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    // String username = fireStoreService.fetchUserNameAndSurname(user.uid) as String;


    void logoutUser() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Farmer Dashboard"),
        centerTitle: true,
      ),

      // Side bar menu
      drawer: FarmerDrawer(user: user),

      body: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // First Container
                Center(
                  child: Container(
                    width: 240,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(0, 4),
                          blurRadius: 4.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // first row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Manage Finances
                            Container(
                              width: 70,
                              height: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade100,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    offset: const Offset(0, 4),
                                    blurRadius: 4.0,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                              ),
                              child: IconButton(
                                // iconSize: 50,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const FarmerAddFinances();
                                    }),
                                  );
                                },
                                icon: Icon(
                                  Icons.monetization_on,
                                  color: Colors.deepPurple,
                                  size: 50,
                                ),
                              ),
                            ),

                            // Manage Operations
                            Container(
                              width: 70,
                              height: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade100,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    offset: const Offset(0, 4),
                                    blurRadius: 4.0,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const FarmerAddOperations();
                                    }),
                                  );
                                },
                                icon: Icon(
                                  Icons.workspaces,
                                  color: Colors.deepPurple,
                                  size: 50,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Second Row
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                "Finances",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                                "Operations",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, right: 15.0),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Choose Action'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const FarmerAddFinances();
                            }),
                          );
                        },
                        child: const Text('Poultry Finances'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const FarmerAddOperations();
                            }),
                          );
                        },
                        child: const Text('Poultry Operations'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Icon(
              Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

// void logoutUser() {
//   FirebaseAuth.instance.signOut();
// }
}

