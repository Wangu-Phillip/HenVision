import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:hen_vision/utils/charts/Percentage_Indicator.dart';
import 'package:hen_vision/utils/charts/line_chart.dart';

import '../operations_analytics.dart';

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
        // leading: Icon(Icons.notifications),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                const Icon(
                  Icons.notifications,
                  size: 20,
                ),

                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ]
            ),
          ),
        ],
        centerTitle: true,
      ),

      // Side bar menu
      drawer: SidebarMenu(user: user),

      // Dashboard charts
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // ICON NAVIGATION'S
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // FIRST CONTAINER
                Container(
                  width: 170,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(0, 1),
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // FIRST ROW
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          // MANAGE FINANCES
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7070E7),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(0, 2),
                                  blurRadius: 2.0,
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
                              icon: const Icon(
                                Icons.monetization_on,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // MANAGE OPERATIONS
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7070E7),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(0, 2),
                                  blurRadius: 2.0,
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
                              icon: const Icon(
                                Icons.workspaces,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // SECOND ROW
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Finances"),
                          Text("Operations"),
                        ],
                      ),

                      // THIRD ROW
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          // OPERATIONS ANALYTICS
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7070E7),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(0, 2),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const OperationsAnalytics();
                                    })
                                );
                              },
                              icon: const Icon(
                                Icons.pie_chart,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // FINANCES ANALYTICS
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7070E7),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(0, 2),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const FinanceAnalytics();
                                  }),
                                );
                              },
                              icon: const Icon(
                                Icons.bar_chart,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Operations \n Analytics"),
                          Text("Finances\nAnalytics"),
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
                        offset: const Offset(0, 1),
                        blurRadius: 1.0,
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

                          // CALENDAR
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7070E7),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(0, 2),
                                  blurRadius: 2.0,
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
                              icon: const Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // MANAGE USERS
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7070E7),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(0, 2),
                                  blurRadius: 2.0,
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
                              icon: const Icon(
                                Icons.people_alt_rounded,
                                color: Colors.white,
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

                          // UPLOAD FILE
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7070E7),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(0, 2),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const UploadFile();
                                  }),
                                );
                              },
                              icon: const Icon(
                                Icons.cloud_upload,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // DOWNLOAD REPORT
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7070E7),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(0, 2),
                                  blurRadius: 2.0,
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
                              icon: const Icon(
                                Icons.download,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Fourth Row
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Upload \n   files"),
                          Text("Download \n  Reports"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 35,
            ),

            /// TODO: Display layers and broilers data using line chart
            // Line chart
            Center(
              child: Container(
                height: 250,
                width: 356,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(0, 1),
                      blurRadius: 0.5,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: const HLineChart(),
              ),
            ),

            const SizedBox(
              height: 35,
            ),

            /// TODO: Calculate finances used from the total budget
            // Finances used
            const HPercentageIndicator(),

            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, right: 15.0),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF7070E7),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text('Choose Action')),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      // MANAGE FINANCES
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
                        style: ButtonStyle(
                          // backgroundColor: WidgetStateProperty.all(color ?? BColors.bdLightGreen),
                          // padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 16.0, horizontal: 17.0)),
                          shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                          elevation: WidgetStateProperty.all(2.0),
                          fixedSize: WidgetStateProperty.all(const Size.fromWidth(170)),
                        ),
                        child: const Text('Poultry Finances'),
                      ),

                      // MANAGE OPERATIONS
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
                        style: ButtonStyle(
                          // backgroundColor: WidgetStateProperty.all(color ?? BColors.bdLightGreen),
                          // padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 16.0, horizontal: 17.0)),
                          shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                          elevation: WidgetStateProperty.all(2.0),
                          fixedSize: WidgetStateProperty.all(const Size.fromWidth(170)),
                        ),
                        child: const Text('Poultry Operations'),
                      ),

                      // MANAGE BUDGET
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          // backgroundColor: WidgetStateProperty.all(color ?? BColors.bdLightGreen),
                          // padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 16.0, horizontal: 17.0)),
                          shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                          elevation: WidgetStateProperty.all(2.0),
                          fixedSize: WidgetStateProperty.all(const Size.fromWidth(170)),
                        ),
                        child: const Text('Budget'),
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
