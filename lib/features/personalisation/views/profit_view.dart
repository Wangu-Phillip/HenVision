
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/charts/pie_chart.dart';

class Profit extends StatefulWidget {
  const Profit({super.key});

  @override
  State<Profit> createState() => _ProfitState();
}

class _ProfitState extends State<Profit> {

  late double totalIncome = 0.0;
  late double totalExpenses = 0.0;
  late double yearlyBudget = 0.0;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [

              const SizedBox(height: 15,),

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
                        DateFormat('dd MMMM yyyy').format(DateTime.now()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
        
                      /// TODO: Automate month analytics
                      // Analytics
                      const Text(
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

              const SizedBox(height: 15,),

              // PIE CHART
              const SizedBox(
                width: 300,
                height: 320,
                child: HPieChart(),
              ),
        
        
              const SizedBox(
                height: 25,
              ),
        
              // category and comparison analytics
              Row(
                children: [
                  const Text(
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
                    style: const TextStyle(
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
                  border: Border.all(
                    width: 0.2,
                    color: Colors.grey,
                  ),
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
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
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
        
                    const Spacer(),
                    // analytics
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        incomeChange >= 0
                            ? 'Up ${incomeChange.toStringAsFixed(2)}%'
                            : 'Down ${(-incomeChange).toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: incomeChange >= 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
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
                  border: Border.all(
                    width: 0.2,
                    color: Colors.grey,
                  ),
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
                          color: Colors.grey,
                          width: 0.5,
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
        
                    const Spacer(),
        
                    // analytics
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        expenseChange >= 0
                            ? 'Up ${expenseChange.toStringAsFixed(2)}%'
                            : 'Down ${(-expenseChange).toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: expenseChange >= 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
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
                  border: Border.all(
                    width: 0.2,
                    color: Colors.grey,
                  ),
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
                          color: Colors.grey,
                          width: 0.5,
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
        
                    const Spacer(),
        
                    // analytics
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        budgetChange >= 0
                            ? 'Up ${budgetChange.toStringAsFixed(2)}%'
                            : 'Down ${(-budgetChange).toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: budgetChange >= 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
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
                  border: Border.all(
                    width: 0.2,
                    color: Colors.grey,
                  ),
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
                          color: Colors.grey,
                          width: 0.5,
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
        
                    const Spacer(),
        
                    // analytics
                    const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text(
                        'Up 67%',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
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
