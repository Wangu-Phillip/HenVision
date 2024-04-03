import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/common/widgets/drawer.dart';
import 'package:hen_vision/features/personalisation/views/Sales.dart';
import 'package:hen_vision/features/personalisation/views/admin/admin_dashboard.dart';
import 'package:hen_vision/features/personalisation/views/operations.dart';
import 'package:hen_vision/utils/charts/pie_chart.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports Overview"),
        centerTitle: true,
      ),

      // Side bar menu
      drawer: SidebarMenu(user: user),

      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(

          child: Column(
            children: [
              const SizedBox(
                height: 25,
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
