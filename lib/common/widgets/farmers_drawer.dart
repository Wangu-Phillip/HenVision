import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_data.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_finances.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_operations.dart';
import 'package:hen_vision/features/personalisation/views/admin/manage_users.dart';
import 'package:hen_vision/features/personalisation/views/finance_analytics.dart';
import 'package:hen_vision/features/personalisation/views/calendar.dart';
import 'package:hen_vision/features/personalisation/views/user/farmer_add_data.dart';
import 'package:hen_vision/features/personalisation/views/user/farmer_add_operations.dart';
import 'package:hen_vision/features/personalisation/views/user_profile.dart';

import '../../features/personalisation/services/firestore_service.dart';
import '../../features/personalisation/views/admin/admin_dashboard.dart';
import '../../features/personalisation/views/reports.dart';
import '../../features/personalisation/views/user/farmer_dashboard.dart';
import '../../features/personalisation/views/user/farmer_upload_file.dart';

class FarmerDrawer extends StatefulWidget {


  FarmerDrawer({
    super.key,
    required user,
  });

  @override
  State<FarmerDrawer> createState() => _FarmerDrawer();
}

class _FarmerDrawer extends State<FarmerDrawer> {

  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  // get user name
  final user = FirebaseAuth.instance.currentUser!;


  // Manage Data Dropdown list
  String _selectedOption = 'Finances';

  @override
  Widget build(BuildContext context) {

    // String username = fireStoreService.fetchUserNameAndSurname(user.uid) as String;

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
                    return const FarmerDashboard();
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

            // Manage Finances
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const FarmerAddFinances();
                  }),
                );
              },
              leading: const Icon(
                Icons.attach_money,
                color: Color(0xFF6D62F7),
              ),
              title: const Text(
                "Add Finances",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

            ),

            // Manage Operations
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const FarmerAddOperations();
                  }),
                );
              },
              leading: const Icon(
                Icons.workspaces,
                color: Color(0xFF6D62F7),
              ),
              title: const Text(
                "Add Operations",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            // Upolad File
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const FileUpload();
                  }),
                );
              },
              leading: const Icon(
                Icons.cloud_upload,
                color: Color(0xFF6D62F7),
              ),
              title: const Text(
                "Upload File",
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

