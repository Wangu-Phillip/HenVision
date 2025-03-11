import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../features/personalisation/services/firestore_service.dart';

class LayersChart extends StatefulWidget {
  const LayersChart({super.key});

  @override
  State<LayersChart> createState() => _LayersChartState();
}

class _LayersChartState extends State<LayersChart> {

  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  late double totalLayerChickens = 0;
  late double mortalityCount = 0;
  late double eggsCollected = 0;

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  void _loadData() {

    // CONTINUOUSLY LISTEN TO CHICKEN MORTALITY COUNT
    fireStoreService.getLayerMortalityCount().listen((data) {
      mortalityCount = data;
    }).onError((error) {
      mortalityCount = 0;
    });

    // CONTINUOUSLY LISTEN TO TOTAL LAYERS
    fireStoreService.getTotalLayers().listen((data) {
      totalLayerChickens = data;
    }).onError((error) {
      totalLayerChickens = 0;
    });

    // CONTINUOUSLY LISTEN TO EGGS COLLECTED
    fireStoreService.getTotalEggsCollectedStream().listen((data) {
      eggsCollected = data;
    }).onError((error) {
      eggsCollected = 0;
    });

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
                //
                // TOTAL LAYER CHICKENS
                PieChartSectionData(
                  // badgeWidget: const Text("Total Chickens"),
                  // badgePositionPercentageOffset: 1.7,
                  value: totalLayerChickens,
                  radius: 55,
                  color: Colors.blue,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //
                // TOTAL MORTALITY COUNT
                PieChartSectionData(
                  value: mortalityCount,
                  radius: 55,
                  color: Colors.yellow,
                  // badgeWidget: const Text("Mortality Count"),
                  // badgePositionPercentageOffset: 1.5,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //
                // TOTAL EGGS COLLECTED
                PieChartSectionData(
                  value: eggsCollected,
                  radius: 55,
                  color: Colors.green,
                  // badgeWidget: const Text("Eggs Collected"),
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
              'Layers',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            Text(
              "$totalLayerChickens",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

          ],
        ),

      ],
    );
  }
}
