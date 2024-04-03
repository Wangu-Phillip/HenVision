import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/common/widgets/drawer.dart';
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
        padding: const EdgeInsets.all(8.0),
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
                  width: 160,
                  height: 140,
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
                                onPressed: () {},
                                icon: Icon(
                                    Icons.monetization_on,
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.workspaces,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),

                        ],
                      ),

                      // second row
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
                              onPressed: () {},
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.bar_chart,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),
                ),

                // Second Container
                Container(
                  width: 160,
                  height: 140,
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.calendar_today,
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.person,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),

                        ],
                      ),

                      // second row
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.document_scanner,
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.download,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),

            // Line chart
            Center(
              child: Container(
                height: 169,
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

            // Finances used
            HPercentageIndicator(),
          ],
        ),
      ),

    );
  }

  // void logoutUser() {
  //   FirebaseAuth.instance.signOut();
  // }
}

