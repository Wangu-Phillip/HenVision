import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/common/widgets/drawer.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_data.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_finances.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_operations.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_users.dart';
import 'package:hen_vision/features/personalisation/views/analytics.dart';
import 'package:hen_vision/features/personalisation/views/calendar.dart';
import 'package:hen_vision/features/personalisation/views/file_upload.dart';
import 'package:hen_vision/features/personalisation/views/generate_pdf.dart';
import 'package:hen_vision/features/personalisation/views/reports.dart';
import 'package:hen_vision/utils/charts/Percentage_Indicator.dart';
import 'package:hen_vision/utils/charts/line_chart.dart';
import 'package:hen_vision/utils/charts/pie_chart.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Dashboard"),
        centerTitle: true,
      ),

      // Side bar menu
      drawer: SidebarMenu(user: user),

      // Dashboard charts
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // icon navigations
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // First Container
                  Container(
                    width: 170,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // first row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Manage Finances
                            Container(
                              width: 50,
                              height: 50,
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
                                      return const ManageData();
                                    }),
                                  );
                                },
                                icon: Icon(
                                  Icons.monetization_on,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),

                            // Manage Operations
                            Container(
                              width: 50,
                              height: 50,
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
                                      return const ManageOperations();
                                    }),
                                  );
                                },
                                icon: Icon(
                                  Icons.workspaces,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Second Row
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Finances"),
                            Text("Operations"),
                          ],
                        ),

                        // third row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
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
                                      return const Analytics();
                                    }),
                                  );
                                },
                                icon: Icon(
                                  Icons.pie_chart,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
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
                                      return const Analytics();
                                    }),
                                  );
                                },
                                icon: Icon(
                                  Icons.bar_chart,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Operations \n Analytics"),
                            Text("Finances \n Analytics"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Second Container
                  Container(
                    width: 170,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // first row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // calendar
                            Container(
                              width: 50,
                              height: 50,
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
                                      return const Calendar();
                                    }),
                                  );
                                },
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),

                            // manage users
                            Container(
                              width: 50,
                              height: 50,
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
                                      return const ManageUsers();
                                    }),
                                  );
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Second Row
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Calendar"),
                            Text("Users"),
                          ],
                        ),

                        // third row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // reports
                            Container(
                              width: 50,
                              height: 50,
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
                                      return UploadFile();
                                    }),
                                  );
                                },
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),

                            // download
                            Container(
                              width: 50,
                              height: 50,
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
                                      return PdfPage();
                                    }),
                                  );
                                },
                                icon: Icon(
                                  Icons.download,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Fourth Row
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Upload \n files"),
                            Text("Generate \n Reports"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 35,
              ),

              /// TODO: Display layers and broilers data using line chart
              // Line chart
              Center(
                child: Container(
                  height: 200,
                  width: 356,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(0, 4),
                        blurRadius: 4.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: HLineChart(),
                ),
              ),

              SizedBox(
                height: 35,
              ),

              /// TODO: Calculate finances used from the total budget
              // Finances used
              HPercentageIndicator(),

              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),

      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 40.0, right: 15.0),
      //   child: FloatingActionButton(
      //     backgroundColor: const Color(0xFF6D62F7),
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) {
      //           return const ManageFinances();
      //         }),
      //       );
      //     },
      //
      //     child: const Icon(Icons.add),
      //
      //   ),
      // ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, right: 15.0),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF6D62F7),
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
                              return const ManageFinances();
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
                              return const ManageOperations();
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
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // void logoutUser() {
  //   FirebaseAuth.instance.signOut();
  // }
}
