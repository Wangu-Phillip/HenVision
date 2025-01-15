import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firestore_service.dart';
import 'admin/layers_view.dart';

class OperationsAnalytics extends StatefulWidget {
  const OperationsAnalytics({super.key});

  @override
  State<OperationsAnalytics> createState() => _OperationsAnalyticsState();
}

class _OperationsAnalyticsState extends State<OperationsAnalytics> with SingleTickerProviderStateMixin {


  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  // Tab controller
  late TabController _tabController;

  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  late double totalIncome = 0.0;
  late double totalExpenses = 0.0;
  late double yearlyBudget = 0.0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Operations Overview"),
        centerTitle: true,
      ),

      body: TabBarView(
        controller: _tabController,
        children: const [
          LayersView(),
        ],
      ),
    );
  }
}
