import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/drawer.dart';
import '../../../utils/charts/expense_pie_chart.dart';
import '../../../utils/charts/income_pie_chart.dart';
import '../../../utils/charts/pie_chart.dart';
import '../services/firestore_service.dart';
import 'Sales.dart';
import 'operations.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {

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
    totalIncome = await fireStoreService.getTotalIncome();
    totalExpenses = await fireStoreService.getTotalExpenses();
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
                            child: const HPieChart(),
                          ),


                          const SizedBox(
                            height: 25,
                          ),

                          // category and comparison analytics
                           Row(
                            children: [
                              Text(
                                "CATEGORY",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                width: 80,
                              ),

                              Text(
                                "COMPARISON TO ${DateFormat('MMMM').format(previousMonth).toUpperCase()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // ANALYTICS START -> Income
                          Container(
                            width: 340,
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
                                Text(
                                  incomeChange >= 0
                                      ? 'Up ${incomeChange.toStringAsFixed(2)}%'
                                      : 'Down ${(-incomeChange).toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    color: incomeChange >= 0 ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Text on the right
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          // category 2 -> Expenses
                          Container(
                            width: 340,
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
                                Text(
                                  expenseChange >= 0
                                      ? 'Up ${expenseChange.toStringAsFixed(2)}%'
                                      : 'Down ${(-expenseChange).toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    color: expenseChange >= 0 ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ), // Text on the right
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          // category 3 -> Budget
                          Container(
                            width: 340,
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
                                Text(
                                  budgetChange >= 0
                                      ? 'Up ${budgetChange.toStringAsFixed(2)}%'
                                      : 'Down ${(-budgetChange).toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    color: budgetChange >= 0 ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ), // Text on the right
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          // category 4 -> Profit
                          Container(
                            width: 340,
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

                    const SizedBox(width: 50,),

                    // Income Categories chart
                    Column(
                      children: [

                        // INCOME PIECHART
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 300,
                            height: 320,
                            child: const IPieChart(),
                          ),
                        ),


                        const SizedBox(
                          height: 25,
                        ),

                        // category and comparison analytics
                         Padding(
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

                              const SizedBox(
                                width: 80,
                              ),

                              Text(
                                "COMPARISON TO ${DateFormat('MMMM').format(previousMonth).toUpperCase()}",
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

                        // ANALYTICS START -> Egg Sales
                        Container(
                          width: 340,
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

                              // pie chart Budget colored portion
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
                                'Egg Sales',
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

                        // category 2 -> Meat Sales
                        Container(
                          width: 340,
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
                                'Meat Sales',
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

                        // category 3 -> Feather Sales
                        Container(
                          width: 340,
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
                                  color: Colors.grey,
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
                                'Feather Sales',
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

                        // category 4 -> Fertilizer Sales
                        Container(
                          width: 340,
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
                                'Fertilizer Sales',
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

                        const SizedBox(
                          height: 25,
                        ),

                        // category 5 -> Chicken Sales
                        Container(
                          width: 340,
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
                                'Chicken Sales',
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

                    const SizedBox(width: 50),

                    // Expenses Categories chart
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        children: [

                          // EXPENSES PIECHART
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Container(
                              width: 300,
                              height: 320,
                              child: const EPieChart(),
                            ),
                          ),

                          // CATEGORIES
                          const SizedBox(
                            height: 25,
                          ),

                          // category and comparison analytics
                           Padding(
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

                                const SizedBox(
                                  width: 80,
                                ),

                                Text(
                                  "COMPARISON TO ${DateFormat('MMMM').format(previousMonth).toUpperCase()}",
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

                          // ANALYTICS START -> Feed Costs
                          Container(
                            width: 340,
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
                                  'Feed Costs',
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

                          // category 2 -> Labor Costs
                          Container(
                            width: 340,
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
                                  'Labor Costs',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  width: 120,
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

                          // category 3 -> Utilities costs
                          Container(
                            width: 340,
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
                                  'Utilities Costs',
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

                          // category 4 -> Veterinary Costs
                          Container(
                            width: 340,
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
                                    color: Colors.grey,
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
                                  'Veterinary Costs',
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

                          const SizedBox(
                            height: 25,
                          ),

                          // category 5 -> Equipment & Supplies Costs
                          Container(
                            width: 340,
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
                                  'Equipment & Supplies Costs',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  width: 50,
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

                          const SizedBox(
                            height: 25,
                          ),

                        ],
                      ),
                    ),

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
