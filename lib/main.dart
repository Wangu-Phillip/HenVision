import 'package:flutter/material.dart';
import 'package:hen_vision/features/personalisation/views/admin/admin_dashboard.dart';
import 'package:hen_vision/features/personalisation/views/change_password.dart';
import 'package:hen_vision/features/personalisation/views/email_check.dart';
import 'package:hen_vision/features/personalisation/views/forgot_password.dart';
import 'package:hen_vision/features/personalisation/views/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AdminDashboard(),
    );
  }
}
