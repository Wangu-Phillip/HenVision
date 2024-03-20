import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/features/personalisation/views/operations.dart';

import '../../../common/widgets/drawer.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({super.key});

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {

  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales Report"),
        centerTitle: true,
      ),

      // Side bar menu
     // drawer: SidebarMenu(user: user),

      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(

          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),

              // Sales & Operations Report buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Sales Report
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const SalesReport();
                        }),
                      );
                    },
                    child: Container(
                      width: 55,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black,
                      ),
                      child: const Text(
                        "Sales",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 15,
                  ),
                  // Operations Report
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const OperationsReport();
                        }),
                      );
                    },
                    child: Container(
                      width: 70,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black,
                      ),
                      child: const Text(
                        "Operations",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              SizedBox(height: 15,),

              // Monthly Sales
              Container(
                width: 400,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),

                // Monthly Sales
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 10),
                      child: Row(
                        children: [
                          const Text(
                            "Montlhy Sales",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(width: 90,),

                          // Broilers Tag
                          Container(
                            width: 55,
                            height: 18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.blue,
                            ),
                            child: const Text(
                              "Broilers",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),


                          const SizedBox(width: 8,),

                          // Layers Tag
                          Container(
                            width: 55,
                            height: 18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.green.shade500,
                            ),
                            child: const Text(
                              "Layers",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25,),

              // Yearly Sales
              Container(
                width: 400,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),

                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Yearly Sales",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          Text(
                            "Broilers",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          Text(
                            "Layers",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 25,),

              // Bar Graph
              Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),

                child: const Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sold Products",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),


                      SizedBox(width: 140,),

                      Text(
                        "Mar - June",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25,),

            ],
          ),
        ),
      ),
    );;
  }

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }
}
