import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/drawer.dart';
import '../../../utils/charts/expense_pie_chart.dart';
import '../../../utils/charts/income_pie_chart.dart';
import '../../../utils/charts/pie_chart.dart';
import 'Sales.dart';
import 'operations.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Overview"),
        centerTitle: true,
      ),

      // Side bar menu
      drawer: SidebarMenu(user: user),

      body: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              // filter
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Calendar icon
                  Icon(
                    Icons.calendar_month,
                  ),

                  // Month of Analysed Data
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      /// TODO: Automate date
                      // Date
                      Text(
                        "June 2022",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      /// TODO: Automate month analytics
                      // Analytics
                      Text(
                        "Down 7% from last month",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),

                  // Filter icon
                  Icon(
                    Icons.filter_alt_outlined,
                  ),
                ],
              ),

              const SizedBox(
                height: 25,
              ),

              // Overview Graphs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    // Income, Expense and Budget Pie chart
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                        width: 300,
                        height: 320,
                        child: const HPieChart(),
                      ),
                    ),

                    const SizedBox(width: 50),

                    /// TODO: Change or Implement a piechart for Income categories with amounts
                    // Income Categories chart
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 300,
                        height: 320,
                        child: const IPieChart(),
                      ),
                    ),

                    const SizedBox(width: 50),

                    /// TODO: Implement a piechart for Expenses categories with amounts
                    // Income Categories chart
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 300,
                        height: 320,
                        child: const EPieChart(),
                      ),
                    ),

                  ],
                )
              ),

              const SizedBox(
                height: 25,
              ),

              // category and comparison analytics
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "CATEGORY",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "COMPARISON TO MAY",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // ANALYTICS START
              Container(
                width: 343,
                height: 52,
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
                child: Row(
                  children: [

                    const SizedBox(
                      width: 16,
                    ),

                    // pie chart Buddget colored portion
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    // pie chart colored title
                    const Text(
                      'Income',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      width: 130,
                    ),
                    // analytics
                    const Text(
                      'Up 3.67%',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // Text on the right
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // category 2
              Container(
                width: 343,
                height: 52,
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
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    // pie chart colored portion
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    // pie chart colored title
                    const Text(
                      'Expenses',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      width: 130,
                    ),
                    // analytics
                    const Text(
                      'Down -3.71%',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // Text on the right
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // category 3
              Container(
                width: 343,
                height: 52,
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
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    // pie chart colored portion
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    // pie chart colored title
                    const Text(
                      'Budget',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      width: 130,
                    ),
                    // analytics
                    const Text(
                      'Up 4.6%',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // Text on the right
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // category 4
              Container(
                width: 343,
                height: 52,
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
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    // pie chart colored portion
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    // pie chart colored title
                    const Text(
                      'Profit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      width: 130,
                    ),
                    // analytics
                    const Text(
                      'Up 67%',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // Text on the right
                  ],
                ),
              ),
              // ANALYTICS END

              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
