import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../features/personalisation/services/firestore_service.dart';

class EPieChart extends StatefulWidget {
  const EPieChart({super.key});

  @override
  State<EPieChart> createState() => _EPieChartState();
}

class _EPieChartState extends State<EPieChart> {
  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  late double totalFeedCosts = 0.0;
  late double totalLaborCosts = 0.0;
  late double totalUtilitiesCosts = 0.0;
  late double totalVeterinaryCosts = 0.0;
  late double totalEquipmentCosts = 0.0;
  late double yearlyBudget = 0.0;

  @override
  void initState() {
    super.initState();
    loadFinanceData();
  }

  Future<void> loadFinanceData() async {
    totalFeedCosts = await fireStoreService.getTotalFeedCosts();
    totalLaborCosts = await fireStoreService.getTotalLaborCosts();
    totalVeterinaryCosts =
    await fireStoreService.getTotalVeterinaryCosts();
    totalUtilitiesCosts =
    await fireStoreService.getTotalUtilityCosts();
    totalEquipmentCosts =
    await fireStoreService.getTotalEquipmentSupplies();
    double? recentBudgetAmount = await fireStoreService.getRecentBudgetAmount();

    if (recentBudgetAmount != null) {
      yearlyBudget = recentBudgetAmount;
      double amountUsed = (totalLaborCosts / yearlyBudget);

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
                  value: totalEquipmentCosts,
                  radius: 55,
                  color: Colors.blue,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // item-2
                PieChartSectionData(
                  value: totalLaborCosts,
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
                  value: totalFeedCosts,
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
                  value: totalVeterinaryCosts,
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
                  value: totalUtilitiesCosts,
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
              'Expense Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'P${(totalFeedCosts +
                  totalLaborCosts +
                  totalUtilitiesCosts +
                  totalVeterinaryCosts +
                  totalEquipmentCosts).toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: (totalFeedCosts +
                    totalLaborCosts +
                    totalUtilitiesCosts +
                    totalVeterinaryCosts +
                    totalEquipmentCosts) >
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
