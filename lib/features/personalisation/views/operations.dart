import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Sales.dart';

class OperationsReport extends StatefulWidget {
  const OperationsReport({super.key});

  @override
  State<OperationsReport> createState() => _OperationsReportState();
}

class _OperationsReportState extends State<OperationsReport> {

  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Operations"),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(

          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),

              // Operations Data
              Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),

                // Monthly Sales
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25.0, top: 10),
                      child: Row(
                        children: [
                          Text(
                            "Operations Data",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25,),

              // Amount Used
              Container(
                width: 350,
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
                            "Amount Used",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          Text(
                            "+45%",
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

              // Operations Costs
              Container(
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),

                child: const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Operations Costs",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      SizedBox(width: 20,),

                      Text(
                        "+75%",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
