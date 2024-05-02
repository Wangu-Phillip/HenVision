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

/// AuthPage is a stateless widget that handles user authentication and navigation.
/// It listens to the authStateChanges stream from FirebaseAuth.instance and navigates
/// to the corresponding dashboard depending on the user's role.
class AuthPage extends StatelessWidget {

  // Constructor for AuthPage
  const AuthPage({Key? key});


  /// The build method returns a Scaffold widget with a StreamBuilder as its body.
  /// The StreamBuilder listens to the authStateChanges stream from FirebaseAuth.instance.
  /// If the user is logged in, it uses a FutureBuilder to fetch the user's role from Firestore.
  /// Depending on the user's role, it navigates to the corresponding dashboard.
  /// If the user's role is not 'farmer' or 'admin', or if the user is not logged in,
  /// it navigates to the Login page.
  @override
  Widget build(BuildContext context) {

    // Initialize firestore Service
    final FireStoreService fireStoreService = FireStoreService();


    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          // Show a loading indicator while waiting for the auth state to change
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // If the user is logged in, fetch their role and navigate to the corresponding dashboard
          if (snapshot.hasData) {
            // User is logged in
            User? user = snapshot.data;
            String? userId = user?.email;
            return FutureBuilder<String?>(
              future: fireStoreService.getUserRole(userId!),
              builder: (context, roleSnapshot) {

                // Show a loading indicator while waiting for the user's role to be fetched
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Navigate to the corresponding dashboard depending on the user's role
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

            // If the user is not logged in, navigate to the Login page
            return const Login();
          }
        },
      ),
    );
  }
}
