import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_data.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_finances.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_operations.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_users.dart';
import 'package:hen_vision/features/personalisation/views/analytics.dart';
import 'package:hen_vision/features/personalisation/views/calendar.dart';
import 'package:hen_vision/features/personalisation/views/user_profile.dart';

import '../../features/personalisation/views/admin/admin_dashboard.dart';
import '../../features/personalisation/views/reports.dart';

class SidebarMenu extends StatefulWidget {


  SidebarMenu({
    super.key,
    required user,
  });

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  // Manage Data Dropdown list
  String _selectedOption = 'Finances';

  @override
  Widget build(BuildContext context) {

    // Side bar menu
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [

            // user photo
            DrawerHeader(
              child: Column(
                children: [
                   const CircleAvatar(
                    // backgroundColor: Colors.black,
                    radius: 45,
                     backgroundImage: AssetImage("assets/user_avatars/user.jpg"),
                  ),
                  const SizedBox(height: 5),

                  // user name
                  Text(
                      "${user.email}",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),

                ],
              ),
            ),

            // Dashboard or Home
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const AdminDashboard();
                  }),
                );
              },
              leading: const Icon(
                  Icons.home,
                color: Color(0xFF6D62F7),
              ),
              title: const Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            // Manage Data
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const ManageData();
                  }),
                );
              },
              leading: const Icon(
                Icons.edit_document,
                color: Color(0xFF6D62F7),
              ),
              title: const Text(
                "Manage Data",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

            ),

            // Users
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const ManageUsers();
                  }),
                );
              },
              leading: const Icon(
                Icons.people,
                color: Color(0xFF6D62F7),
              ),
              title: const Text(
                "Users",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            // Reports
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const Reports();
                  }),
                );
              },
              leading: const Icon(
                  Icons.download,
                color: Color(0xFF6D62F7),
              ),
              title: const Text(
                "Reports",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            // Analytics
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const Analytics();
                  }),
                );
              },
              leading: const Icon(
                  Icons.bar_chart,
                color: Color(0xFF6D62F7),
              ),
              title: const Text(
                "Analytics",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            // Calendar
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Calendar();
                  }),
                );
              },
              leading: const Icon(
                  Icons.calendar_today,
                color: Color(0xFF6D62F7),
              ),
              title: const Text(
                "Calendar",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            // Settings
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return UserProfile(user: user);
                  }),
                );
              },
              leading: const Icon(
                  Icons.settings,
                color: Color(0xFF6D62F7),
              ),
              title: const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(height: 25,),

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
    );
  }

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }
}

