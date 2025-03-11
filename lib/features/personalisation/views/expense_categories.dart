import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/charts/expense_pie_chart.dart';


class ExpenseCat extends StatefulWidget {
  const ExpenseCat({super.key});

  @override
  State<ExpenseCat> createState() => _ExpenseCatState();
}

class _ExpenseCatState extends State<ExpenseCat> {


  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    DateTime previousMonth = DateTime(now.year, now.month - 1, 1);

    // Expenses Categories chart
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [

             const  SizedBox(height: 15,),

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

              // EXPENSES PIE CHART
              const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: SizedBox(
                  width: 300,
                  height: 320,
                  child: EPieChart(),
                ),
              ),
        
              // CATEGORIES
              const SizedBox(
                height: 25,
              ),
        
              // category and comparison analytics
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'Feed Costs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
        
                    const Spacer(),
        
                    // analytics
                    const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text(
                        'Up 3.67%',
                        style: TextStyle(
                          color: Colors.green,
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
        
              // category 2 -> Labor Costs
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
                      'Labor Costs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
        
                    const Spacer(),
        
                    // analytics
                    const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text(
                        'Down -3.71%',
                        style: TextStyle(
                          color: Colors.red,
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
        
              // category 3 -> Utilities costs
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
                      'Utilities Costs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
        
                    const Spacer(),
        
                    // analytics
                    const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text(
                        'Up 4.6%',
                        style: TextStyle(
                          color: Colors.green,
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
        
              // category 4 -> Veterinary Costs
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
                        color: Colors.grey,
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
                      'Veterinary Costs',
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
        
              const SizedBox(
                height: 25,
              ),
        
              // category 5 -> Equipment & Supplies Costs
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
                      'Equipment & Supplies Costs',
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
