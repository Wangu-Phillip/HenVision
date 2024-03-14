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

              const ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

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
