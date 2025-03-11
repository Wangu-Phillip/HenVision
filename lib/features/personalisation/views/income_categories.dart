import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/charts/income_pie_chart.dart';

class IncomeCat extends StatefulWidget {
  const IncomeCat({super.key});

  @override
  State<IncomeCat> createState() => _IncomeCatState();
}

class _IncomeCatState extends State<IncomeCat> {

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    DateTime previousMonth = DateTime(now.year, now.month - 1, 1);

     // Income Categories chart
    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
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

              // INCOME PIE CHART
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  width: 300,
                  height: 320,
                  child: IPieChart(),
                ),
              ),


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

              // ANALYTICS START -> Egg Sales
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
                      'Egg Sales',
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

              // category 2 -> Meat Sales
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
                      'Meat Sales',
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

              // category 3 -> Feather Sales
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
                      'Feather Sales',
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

              // category 4 -> Fertilizer Sales
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
                      'Fertilizer Sales',
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

              // category 5 -> Chicken Sales
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
                      'Chicken Sales',
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
    );

  }
}
