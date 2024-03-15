import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),

      // Side bar menu
      drawer: Drawer(
        elevation: 1,
        child: Container(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),

                    Text("${user.email}"),
                  ],
                ),
              ),

              const SizedBox(height: 25,),

              // Dashboard
              const ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

              // Manage Data
              ListTile(
                onTap: () => (), //navigateToManageData(), // Replace with your navigation logic
                leading: const Icon(Icons.edit),
                title: const Text(
                  "Manage Data",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

              // Reports
              ListTile(
                onTap: () => (), //navigateToReports(), // Replace with your navigation logic
                leading: const Icon(Icons.bar_chart),
                title: const Text(
                  "Reports",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

              // Calendar
              ListTile(
                onTap: () => (), //navigateToCalendar(), // Replace with your navigation logic
                leading: const Icon(Icons.calendar_today),
                title: const Text(
                  "Calendar",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

              // Export Data
              ListTile(
                onTap: () => (), //navigateToExportData(), // Replace with your navigation logic
                leading: const Icon(Icons.download),
                title: const Text(
                  "Export Data",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

              // Settings
              ListTile(
                onTap: () =>  (), //navigateToSettings(), // Replace with your navigation logic
                leading: const Icon(Icons.settings),
                title: const Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 140,),

              // Logout
              ListTile(
                onTap: logoutUser,
                leading: const Icon(Icons.logout),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

            ],
          ),


        ),
      ),

      // Dashboard charts
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),

            Center(
              child: Container(
                height: 169,
                width: 356,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: LineChart(
                  swapAnimationDuration: const Duration(microseconds: 250),
                  sampleData1,
                ),
              ),
            )
          ],
        ),
      ),

    );
  }

  void logoutUser() {
    FirebaseAuth.instance.signOut();
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
    color: Colors.grey,
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

    case 4:
      text = '4m';
      break;

    case 5:
      text = '5m';
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
    color: Colors.grey,
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

FlGridData get gridData => FlGridData(show: false);

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
  color: Colors.white,
  barWidth: 2,
  isStrokeCapRound: true,
  dotData: FlDotData(show: true),
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
  color: Colors.blue,
  barWidth: 2,
  isStrokeCapRound: true,
  dotData: FlDotData(show: true),
  belowBarData: BarAreaData(show: false),
  spots: const [
    FlSpot(0, 1.4),
    FlSpot(1, 1.3),
    FlSpot(3, 2.4),
    FlSpot(5, 1.6),
    FlSpot(7, 2.4),
    FlSpot(10, 1.7),
    FlSpot(12, 2.9),
    FlSpot(13.5, 3.4)
  ],
);