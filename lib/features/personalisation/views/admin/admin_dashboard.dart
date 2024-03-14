import 'package:firebase_auth/firebase_auth.dart';
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
    );
  }

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }
}
