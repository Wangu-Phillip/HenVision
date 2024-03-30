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

              // Monthly Sales
              Container(
                width: 350,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Montlhy Sales",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          // Broilers Tag
                          Container(
                            alignment: Alignment.center,
                            width: 55,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.blue,
                            ),
                            child: const Text(
                              "Broilers",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white
                              ),
                            ),
                          ),

                          // Layers Tag
                          Container(
                            alignment: Alignment.center,
                            width: 55,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.green.shade500,
                            ),
                            child: const Text(
                              "Layers",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
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
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),

                child: const Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sold Products",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: 20,),

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
    );
  }

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }
}
