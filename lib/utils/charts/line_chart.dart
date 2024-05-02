import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HLineChart extends StatefulWidget {
  const HLineChart({super.key});

  @override
  State<HLineChart> createState() => _HLineChartState();
}

class _HLineChartState extends State<HLineChart> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Monthly Sales',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
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
      text = '1m';
      break;

    case 2:
      text = '2m';
      break;

    case 3:
      text = '3m';
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
    case 2:
      text = const Text(
        '2020',
        style: style,
      );
      break;

    case 7:
      text = const Text(
        '2021',
        style: style,
      );
      break;

    case 12:
      text = const Text(
        '2022',
        style: style,
      );
      break;

    default:
      text = const Text('');
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10,
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