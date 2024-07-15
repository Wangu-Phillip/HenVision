import 'package:flutter/material.dart';
import 'package:hen_vision/utils/charts/pie_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../features/personalisation/services/firestore_service.dart';

class HPercentageIndicator extends StatefulWidget {
  const HPercentageIndicator({super.key});

  @override
  State<HPercentageIndicator> createState() => _HPercentageIndicatorState();
}

class _HPercentageIndicatorState extends State<HPercentageIndicator> {

  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  late double totalExpenses = 0.0;
  late double yearlyBudget = 0.0;
  double amountUsed = 0.0;

  @override
  void initState() {
    super.initState();
    _loadFinanceData();
  }

  void _loadFinanceData()  {

    // CONTINUOUSLY LISTEN TO EXPENSES CHANGES
    fireStoreService.getTotalExpensesStream().listen((expenses) {
      setState(() {
        totalExpenses = expenses;
      });
    }).onError((error) {
      setState(() {
        totalExpenses = 0.0;
      });
    });

    // CONTINUOUSLY LISTEN TO BUDGET CHANGES
    fireStoreService.getRecentBudgetAmountStream().listen((budget) {
      setState(() {
        if (budget != null) {
          yearlyBudget = budget;
          amountUsed = (totalExpenses / yearlyBudget);
        }
      });
    });

  }


  @override
  Widget build(BuildContext context) {

    return Container(
      width: 340,
      height: 240,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(0, 0.5),
            blurRadius: 0.5,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

           Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
            child: Text(
              "Finances Used In ${DateTime.now().year}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Center(
            child: CircularPercentIndicator(
              radius: 80,
              lineWidth: 15,
              percent: amountUsed > 1.0 ? 1.0 : amountUsed,
              animation: true,
              animationDuration: 1000,
              progressColor: Colors.deepPurple,
              // backgroundColor: Colors.deepPurple.shade100,
              circularStrokeCap: CircularStrokeCap.round,
              arcType: ArcType.FULL,
              arcBackgroundColor: Colors.deepPurple.shade100,
              center: Text(
                amountUsed > 1.0 ? '+${(amountUsed*100).toStringAsFixed(1)}%' : '${(amountUsed*100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: amountUsed > 1.0 ? Colors.black : Colors.black,
                ),
              ),
            ),
          ),

          Center(
            child: Text(
              "P${totalExpenses.toStringAsFixed(2)} / P${yearlyBudget.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
