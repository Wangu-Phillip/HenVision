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

      body: SingleChildScrollView(

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

            const SizedBox(height: 15,),

            // Operations Data
            Container(
              width: 400,
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
                      "Operations Costs",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),


                    SizedBox(width: 140,),

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
    );
  }

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }
}
