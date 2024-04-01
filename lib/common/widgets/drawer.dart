import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_finances.dart';
import 'package:hen_vision/features/personalisation/views/analytics.dart';
import 'package:hen_vision/features/personalisation/views/user_profile.dart';

import '../../features/personalisation/views/admin/admin_dashboard.dart';
import '../../features/personalisation/views/reports.dart';

class SidebarMenu extends StatelessWidget {

  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  SidebarMenu({
    super.key,
    required user,
  });

  @override
  Widget build(BuildContext context) {

    // Side bar menu
    return Drawer(
      child: Container(
        child: ListView(
          children: [

            // user photo
            DrawerHeader(
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 45,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),

                  // user name
                  Text(
                      "${user.email}",
                    style: TextStyle(
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
                    return const ManageFinances();
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
              leading: Icon(
                  Icons.document_scanner,
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
              onTap: () => (),
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

            // Export Data
            ListTile(
              onTap: () => (),
              leading: const Icon(
                  Icons.download,
                color: Color(0xFF6D62F7),
              ),
              title: const Text(
                "Export Data",
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

