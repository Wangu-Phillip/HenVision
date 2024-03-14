import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),

      drawer: Drawer(
        elevation: 1,
        child: Container(
          child: ListView(
            children: const [
              DrawerHeader(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 50,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),

                      Text("Admin: John Doe"),
                    ],
                  ),
              ),

              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }
}
