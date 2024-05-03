import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hen_vision/features/personalisation/views/op_piechart.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/drawer.dart';
import '../../../utils/charts/expense_pie_chart.dart';
import '../../../utils/charts/income_pie_chart.dart';
import '../../../utils/charts/pie_chart.dart';
import '../services/firestore_service.dart';
import 'Sales.dart';
import 'operations.dart';

class OperationsAnalytics extends StatefulWidget {
  const OperationsAnalytics({super.key});

  @override
  State<OperationsAnalytics> createState() => _OperationsAnalytics();
}

class _OperationsAnalytics extends State<OperationsAnalytics> {

  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();


  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  late double totalIncome = 0.0;
  late double totalExpenses = 0.0;
  late double yearlyBudget = 0.0;

  @override
  void initState() {
    super.initState();
    loadFinanceData();
  }

  Future<void> loadFinanceData() async {
    totalIncome = await fireStoreService.getTotalEggsCollected();
    totalExpenses = await fireStoreService.getTotalSoldBroilers();
    double? recentBudgetAmount = await fireStoreService.getRecentBudgetAmount();

    print(totalExpenses);
    print(totalIncome);

    if (recentBudgetAmount != null) {
      yearlyBudget = recentBudgetAmount;
      double amountUsed = (totalExpenses / yearlyBudget);

      setState(() {}); // Update the UI with the new data
    } else {
      print('No recent budget amount found.');
    }
  }


  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    DateTime previousMonth = DateTime(now.year, now.month - 1, 1);

    Random random = Random();
    int min = 10000;
    int max = 50000;
    int randomValue = min + random.nextInt(max - min);

    double incomeChange = randomValue != 0 ? (totalIncome.roundToDouble() / 89598) * 100 : 0;
    double expenseChange = totalExpenses.roundToDouble() != 0 ? (totalExpenses.roundToDouble() / 68554) * 100 : 0;
    double budgetChange = yearlyBudget.roundToDouble() != 0 ? (yearlyBudget.roundToDouble() / 194560) * 100 : 0;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Analytics Overview"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Calendar icon
                  // Icon(
                  //   Icons.calendar_month,
                  // ),

                  // Month of Analysed Data
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      /// TODO: Automate date
                      // Date
                      Text(
                        "${DateFormat('dd MMMM yyyy').format(DateTime.now())}",
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
                  // Icon(
                  //   Icons.filter_alt_outlined,
                  // ),
                ],
              ),

              // Overview Graphs
              // Income, Expense and Budget Pie chart
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [

                      // Income, Expense and Budget Pie chart
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Column(

                          children: [

                            Container(
                              width: 300,
                              height: 320,
                              child: const OPPieChart(),
                            ),


                          ],
                        ),
                      ),

                      const SizedBox(width: 50,),


                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
