import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../features/personalisation/services/firestore_service.dart';

class IPieChart extends StatefulWidget {
  const IPieChart({super.key});

  @override
  State<IPieChart> createState() => _IPieChartState();
}

class _IPieChartState extends State<IPieChart> {
  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  late double totalEggSalesAmount = 0.0;
  late double totalMeatSalesAmount = 0.0;
  late double totalFertilizerSalesAmount = 0.0;
  late double totalFeatherSalesAmount = 0.0;
  late double totalChickenSalesAmount = 0.0;
  late double yearlyBudget = 0.0;

  @override
  void initState() {
    super.initState();
    loadFinanceData();
  }

  Future<void> loadFinanceData() async {
    totalEggSalesAmount = await fireStoreService.getTotalEggSalesAmount();
    totalMeatSalesAmount = await fireStoreService.getTotalMeatSalesAmount();
    totalFeatherSalesAmount =
        await fireStoreService.getTotalFeatherSalesAmount();
    totalFertilizerSalesAmount =
        await fireStoreService.getTotalFertilizerSalesAmount();
    totalChickenSalesAmount =
        await fireStoreService.getTotalChickenSalesAmount();
    double? recentBudgetAmount = await fireStoreService.getRecentBudgetAmount();

    if (recentBudgetAmount != null) {
      yearlyBudget = recentBudgetAmount;
      double amountUsed = (totalMeatSalesAmount / yearlyBudget);

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
                  value: totalChickenSalesAmount,
                  radius: 55,
                  color: Colors.blue,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // item-2
                PieChartSectionData(
                  value: totalMeatSalesAmount,
                  radius: 55,
                  color: Colors.green,
                  // badgeWidget: const Text("Expenses"),
                  // badgePositionPercentageOffset: 1.5,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // item-3
                PieChartSectionData(
                  value: totalEggSalesAmount,
                  radius: 55,
                  color: Colors.yellow,
                  // badgeWidget: const Text("Income"),
                  // badgePositionPercentageOffset: 2,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // item-4
                PieChartSectionData(
                  value: totalFeatherSalesAmount,
                  radius: 55,
                  color: Colors.grey,
                  // badgeWidget: const Text("Income"),
                  // badgePositionPercentageOffset: 2,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // item-5
                PieChartSectionData(
                  value: totalFertilizerSalesAmount,
                  radius: 55,
                  color: Colors.purple,
                  // badgeWidget: const Text("Income"),
                  // badgePositionPercentageOffset: 2,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Amount used in the middle of pie chart
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Income Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'P${(totalEggSalesAmount +
                  totalMeatSalesAmount +
                  totalFertilizerSalesAmount +
                  totalFeatherSalesAmount +
                  totalChickenSalesAmount).toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: (totalEggSalesAmount +
                            totalMeatSalesAmount +
                            totalFertilizerSalesAmount +
                            totalFeatherSalesAmount +
                            totalChickenSalesAmount) >
                        0
                    ? Colors.green.shade500
                    : Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
