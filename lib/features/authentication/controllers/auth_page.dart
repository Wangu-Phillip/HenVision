import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/features/personalisation/views/admin/admin_dashboard.dart';
import 'package:hen_vision/features/personalisation/views/login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // user is logged in
            if(snapshot.hasData) {
              return const AdminDashboard();
            }
            // User is not logged in
            else {
              return const Login();
            }
          },
      ),
    );
  }
}
