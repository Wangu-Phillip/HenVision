// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hen_vision/features/personalisation/views/admin/admin_dashboard.dart';
// import 'package:hen_vision/features/personalisation/views/login.dart';
//
// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             // user is logged in
//             if(snapshot.hasData) {
//               return const AdminDashboard();
//             }
//             // User is not logged in
//             else {
//               return const Login();
//             }
//           },
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/features/personalisation/views/admin/admin_dashboard.dart';
import 'package:hen_vision/features/personalisation/views/login.dart';
import '../../personalisation/services/firestore_service.dart';
import '../../personalisation/views/user/farmer_dashboard.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {

    // Initialize firestore Service
    final FireStoreService fireStoreService = FireStoreService();


    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            // User is logged in
            User? user = snapshot.data;
            String? userId = user?.email;
            return FutureBuilder<String?>(
              future: fireStoreService.getUserRole(userId!),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                String? role = roleSnapshot.data;

                switch (role) {
                  case 'farmer':
                    return const FarmerDashboard();
                  case 'admin':
                    return const AdminDashboard();
                  default:
                    return const Login();
                }
              },
            );
          } else {
            // User is not logged in
            return const Login();
          }
        },
      ),
    );
  }
}
