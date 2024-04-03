import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HPercentageIndicator extends StatefulWidget {
  const HPercentageIndicator({super.key});

  @override
  State<HPercentageIndicator> createState() => _HPercentageIndicatorState();
}

class _HPercentageIndicatorState extends State<HPercentageIndicator> {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 340,
      height: 230,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(0, 4),
            blurRadius: 4.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 10.0),
            child: Text(
              "Finances Used",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Center(
            child: CircularPercentIndicator(
              radius: 80,
              lineWidth: 15,
              percent: 0.65,
              animation: true,
              animationDuration: 1000,
              progressColor: Colors.deepPurple,
              // backgroundColor: Colors.deepPurple.shade100,
              circularStrokeCap: CircularStrokeCap.round,
              arcType: ArcType.FULL,
              arcBackgroundColor: Colors.deepPurple.shade100,
              center: const Text(
                "65%",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
