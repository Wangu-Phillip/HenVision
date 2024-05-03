import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HLineChart extends StatefulWidget {
  const HLineChart({super.key});

  @override
  State<HLineChart> createState() => _HLineChartState();
}

class _HLineChartState extends State<HLineChart> {

  late List<FlSpot> incomeSpots;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('income').get();

    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;

    incomeSpots = docs
        .map((doc) => FlSpot(
      doc['date'].toDate().month.toDouble(),
      doc['amount'].toDouble(),
    )).toList();

    setState(() {});
  }


  LineChartData get sampleData1 => LineChartData(
    gridData: gridData,
    titlesData: titlesData,
    borderData: borderData,
    lineBarsData: lineBarsData,
    minX: 0,
    maxX: 14,
    maxY: 4,
    minY: 0,
  );

  List<LineChartBarData> get lineBarsData => [
    lineChartBarData1,
    lineChartBarData2,
  ];

  FlTitlesData get titlesData => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  Widget leftTitlesWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    String text;

    switch (value.toInt()) {
      case 1:
        text = '5k';
        break;

      case 2:
        text = '10k';
        break;

      case 3:
        text = '15k';
        break;

      case 4:
        text = '20k';
        break;

      case 5:
        text = '25k';
        break;


      default:
        return Container();
    }

    return Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    );
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitlesWidget,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    Widget text;

    switch (value.toInt()) {
      case 1:
        text = const Text(
          'Jan',
          style: style,
        );
        break;
      case 2:
        text = const Text(
          'Feb',
          style: style,
        );
        break;

      case 3:
        text = const Text(
          'Mar',
          style: style,
        );
        break;

      case 4:
        text = const Text(
          'Apr',
          style: style,
        );
        break;

      case 5:
        text = const Text(
          'May',
          style: style,
        );
        break;

      case 6:
        text = const Text(
          'Jun',
          style: style,
        );
        break;

      case 7:
        text = const Text(
          'Jul',
          style: style,
        );
        break;

      case 8:
        text = const Text(
          'Aug',
          style: style,
        );
        break;

      case 9:
        text = const Text(
          'Sep',
          style: style,
        );
        break;

      case 10:
        text = const Text(
          'Oct',
          style: style,
        );
        break;

      case 11:
        text = const Text(
          'Nov',
          style: style,
        );
        break;

      case 12:
        text = const Text(
          'Dec',
          style: style,
        );
        break;

      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => FlGridData(
    show: true,
    drawHorizontalLine: true,
    drawVerticalLine: false,
  );

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: const Border(
      bottom: BorderSide(color: Colors.grey, width: 1),
      left: BorderSide(color: Colors.grey),
      right: BorderSide(color: Colors.transparent),
      top: BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarData1 => LineChartBarData(
    isCurved: true,
    color: Colors.purple.shade300,
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(0, 0),
      FlSpot(1, 1),
      FlSpot(3, 1.5),
      FlSpot(5, 1.6),
      FlSpot(7, 3.4),
      FlSpot(10, 2),
      FlSpot(12, 2.5),
      FlSpot(13, 2.3),
      FlSpot(13.9, 3.0)
    ],
  );


  LineChartBarData get lineChartBarData2 => LineChartBarData(
    isCurved: true,
    color: Colors.purple.shade700,
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(0, 0.2),
      FlSpot(1, 0.5),
      FlSpot(3, 2.4),
      FlSpot(5, 1.6),
      FlSpot(7, 2.4),
      FlSpot(10, 1.7),
      FlSpot(12, 2.9),
      FlSpot(13.5, 3.4)
    ],
  );


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Monthly Chicken Sales',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                Icons.circle,
              size: 15,
              color: Colors.purple,
            ),
            Text("Broilers"),

            SizedBox(width: 25,),

            Icon(
              Icons.circle,
              size: 15,
              color: Colors.deepPurple,
            ),
            Text("Layers"),

          ],
        ),

        Expanded(
          child: LineChart(
            swapAnimationDuration: const Duration(microseconds: 250),
            sampleData1,
          ),
        ),
      ],
    );
  }
}






