import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hen_vision/features/personalisation/views/expense_categories.dart';
import 'package:hen_vision/features/personalisation/views/income_categories.dart';
import 'package:hen_vision/features/personalisation/views/profit_view.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/drawer.dart';
import '../../../utils/charts/expense_pie_chart.dart';
import '../../../utils/charts/income_pie_chart.dart';
import '../../../utils/charts/pie_chart.dart';
import '../services/firestore_service.dart';
import 'Sales.dart';
import 'operations.dart';

class FinanceAnalytics extends StatefulWidget {
  const FinanceAnalytics({super.key});

  @override
  State<FinanceAnalytics> createState() => _FinanceAnalyticsState();
}

class _FinanceAnalyticsState extends State<FinanceAnalytics> with SingleTickerProviderStateMixin {

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

    loadFinanceData();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> loadFinanceData() async {
    totalIncome = await fireStoreService.getTotalIncome();
    totalExpenses = await fireStoreService.getTotalExpenses();
    double? recentBudgetAmount = await fireStoreService.getRecentBudgetAmount();

    if (recentBudgetAmount != null) {
      yearlyBudget = recentBudgetAmount;
      double amountUsed = (totalExpenses / yearlyBudget);

      setState(() {}); // Update the UI with the new data
    } else {
      if (kDebugMode) {
        print('No recent budget amount found.');
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    DateTime previousMonth = DateTime(now.year, now.month - 1, 1);

    Random random = Random();
    int min = 10000;
    int max = 50000;
    int randomValue = min + random.nextInt(max - min);

    double incomeChange = randomValue != 0 ? (totalIncome.roundToDouble() / 89598) * 100 : 0;
    double expenseChange = totalExpenses.roundToDouble() != 0 ? (totalExpenses.roundToDouble() / 68554) * 100 : 0;
    double budgetChange = yearlyBudget.roundToDouble() != 0 ? (yearlyBudget.roundToDouble() / 194560) * 100 : 0;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Finances Overview"),
        centerTitle: true,
      ),

      // Side bar menu
      drawer: SidebarMenu(user: user),

      body: TabBarView(
        controller: _tabController,
        children: const [
          Profit(),
          IncomeCat(),
          ExpenseCat(),
        ],
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(1,0),
              blurRadius: 1.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: TabBar(
          controller: _tabController,
          isScrollable: false,
          indicatorColor: const Color(0xFF7070E7),
          labelColor:  const Color(0xFF7070E7),
          tabs: const [
            Tab(text: 'Profit/Loss'),
            Tab(text: 'Income'),
            Tab(text: 'Expense\'s'),
          ],
        ),
      ),
    );
  }
}
