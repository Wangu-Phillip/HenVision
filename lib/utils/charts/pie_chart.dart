import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../features/personalisation/services/firestore_service.dart';

class HPieChart extends StatefulWidget {
  const HPieChart({super.key});

  @override
  State<HPieChart> createState() => _HPieChartState();
}

class _HPieChartState extends State<HPieChart> {

  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

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
    return Stack(
      alignment: Alignment.center,
      children: [

        // pie chart diagram
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              //
              BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(0, 4),
                blurRadius: 4.0,
                spreadRadius: 0.0,
              ),
            ],

          ),
          child: PieChart(
            swapAnimationDuration: const Duration(milliseconds: 750),
            swapAnimationCurve: Curves.easeInOutQuint,
            PieChartData(
              centerSpaceRadius: 90,
              sectionsSpace: 1,
              sections: [
                // item-1
                PieChartSectionData(
                  // badgeWidget: const Text("Budget"),
                  // badgePositionPercentageOffset: 1.7,
                  value: yearlyBudget,
                  radius: 55,
                  color: Colors.blue,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // item-2
                PieChartSectionData(
                  value: totalExpenses,
                  radius: 55,
                  color: Colors.yellow,
                  // badgeWidget: const Text("Expenses"),
                  // badgePositionPercentageOffset: 1.5,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // item-3
                PieChartSectionData(
                  value: totalIncome,
                  radius: 55,
                  color: Colors.green,
                  // badgeWidget: const Text("Income"),
                  // badgePositionPercentageOffset: 2,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // item-4

              ],
            ),
          ),
        ),

        // Amount used in the middle of pie chart
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [

             const Text(
               'Profit/Loss',
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 20,
               ),
             ),

             Text(
                'P${(totalIncome - totalExpenses).toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: (totalIncome - totalExpenses) > 0 ? Colors.green.shade500 : Colors.red,
                ),
             ),

           ],
         ),



      ],
    );
  }
}
