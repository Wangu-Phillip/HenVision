import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HPieChart extends StatefulWidget {
  const HPieChart({super.key});

  @override
  State<HPieChart> createState() => _HPieChartState();
}

class _HPieChartState extends State<HPieChart> {
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
                  //badgeWidget: const Text("Operations"),
                  //badgePositionPercentageOffset: 1.7,
                  value: 20.5,
                  radius: 55,
                  color: Colors.blue,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // item-2
                PieChartSectionData(
                  value: 60.31,
                  radius: 55,
                  color: Colors.yellow,
                  //badgeWidget: const Text("Equipment"),
                  //badgePositionPercentageOffset: 2,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // item-3
                PieChartSectionData(
                  value: 51.7,
                  radius: 55,
                  color: Colors.green,
                  //badgeWidget: const Text("Broilers"),
                  //badgePositionPercentageOffset: 2,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // item-4
                PieChartSectionData(
                  value: 33.4,
                  radius: 55,
                  color: Colors.purple,
                 // badgeWidget: const Text("Layers"),
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
        const Text(
          "P98,252.38",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
