import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/drawer.dart';
import '../../services/firestore_service.dart';
import 'admin_dashboard.dart';

class ManageFinances extends StatefulWidget {
  const ManageFinances({super.key});

  @override
  State<ManageFinances> createState() => _ManageFinancesState();
}

class _ManageFinancesState extends State<ManageFinances> {

  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  // buttons checker
  bool isIncomeSelected = true;
  bool isExpenseSelected = false;

  // loading checker
  bool _isLoading = false;

  //
  DateTime? selectedDate;
  String? expenseSelectedCategory;
  String? incomeSelectedCategory;

  // Text fields controllers
  final _expenseAmountController = TextEditingController();
  final _expenseDescriptionController = TextEditingController();
  final _expenseCustomerController = TextEditingController();


  final _incomeAmountController = TextEditingController();
  final _incomeDescriptionController = TextEditingController();
  final _incomeCustomerController = TextEditingController();

  @override
  void dispose() {
    _expenseAmountController.dispose();
    _expenseDescriptionController.dispose();

    _incomeAmountController.dispose();
    _incomeDescriptionController.dispose();

    super.dispose();
  }

  // Expenses categories list
  List<String> expensesCategories = [
    'Feed Costs',
    'Labor Costs',
    'Utilities',
    'Veterinary Care',
    'Equipment & Supplies',
  ];

  // Income categories list
  List<String> incomeCategories = [
    'Egg Sales',
    'Meat Sales',
    'Feather Sales',
    'Fertilizer Sales',
    'Chicken Sales',
  ];

  // Pick a date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    // get user name
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Manage Finances"),
        centerTitle: true,
      ),

      // Side bar menu
      drawer: SidebarMenu(user: user),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // Expenses and Income Buttons
            Center(
              child: Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 0.1,
                  ),
                  boxShadow: [
                    //
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(0, 0.5),
                      blurRadius: 0.5,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // Expenses button
                    GestureDetector(
                      onTap: () {
                          setState(() {
                          isExpenseSelected = false;
                          isIncomeSelected = true;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isIncomeSelected ? const Color(0xFF6D62F7) : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Expenses",
                          style: TextStyle(
                            color: isIncomeSelected ? Colors.white : Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    // Income Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpenseSelected = true;
                          isIncomeSelected = false;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isExpenseSelected ? const Color(0xFF6D62F7) : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Income",
                          style: TextStyle(
                            color: isExpenseSelected ? Colors.white : Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),

            const SizedBox(height: 25,),

            // Input Fields
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpenseSelected || isIncomeSelected ? 550 : 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    // Expenses input fields
                    if (isIncomeSelected)
                        Padding(
                          padding: const EdgeInsets.only(left: 35, right: 20.0),
                          child: Container(
                            padding: const EdgeInsets.all(14.0),
                            width: 300,
                            height: 550,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // category text field
                                const Text(
                                  "Category:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                DropdownButtonFormField<String>(
                                  value: expenseSelectedCategory,
                                  hint: const Text('Select Category'),
                                  items: expensesCategories.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      expenseSelectedCategory = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25,),

                                // Amount text & text field
                                const Text(
                                  "Amount:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                TextFormField(
                                  controller: _expenseAmountController,
                                  decoration: InputDecoration(
                                    hintText: "P 0.00",
                                    filled: true,
                                    fillColor: Colors.white,
                                    //border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25,),

                                // Customer text & text field
                                const Text(
                                  "Customer/Business name:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                TextFormField(
                                  controller: _expenseCustomerController,
                                  decoration: InputDecoration(
                                    hintText: "XYZ Company",
                                    filled: true,
                                    fillColor: Colors.white,
                                    //border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25,),

                                // Date & text field
                                const Text(
                                  "Date:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                TextField(
                                  readOnly: true,
                                  enabled: false,
                                  controller: TextEditingController(
                                    text: selectedDate != null
                                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                        : "",
                                  ),
                                  onTap: () => _selectDate(context),
                                  decoration: InputDecoration(
                                    hintText: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                    suffixIcon: const Icon(Icons.calendar_month),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25,),

                                // Description
                            const Text(
                              "Description:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),


                            TextField(
                              controller: _expenseDescriptionController,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: 'Enter Description',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none
                                ),
                              ),
                            ),


                              ],
                            ),

                          ),
                        ),

                    // Income input fields
                    if (isExpenseSelected)
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                          child: Container(
                            padding: const EdgeInsets.all(14.0),
                            width: 300,
                            height: 550,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // category text field
                                const Text(
                                  "Category:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                DropdownButtonFormField<String>(
                                  value: incomeSelectedCategory,
                                  hint: const Text('Select Category'),
                                  items: incomeCategories.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      incomeSelectedCategory = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(height: 25,),

                                // Amount text & text field
                                const Text(
                                  "Amount:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                TextField(
                                  controller: _incomeAmountController,
                                  decoration: InputDecoration(
                                    hintText: "P 0.00",
                                    filled: true,
                                    fillColor: Colors.white,
                                    //border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25,),

                                // CUSTOMER NAME
                                const Text(
                                  "Customer/Business name:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                TextFormField(
                                  controller: _incomeCustomerController,
                                  decoration: InputDecoration(
                                    hintText: "John Dory",
                                    filled: true,
                                    fillColor: Colors.white,
                                    //border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25,),

                                // Date & text field
                                const Text(
                                  "Date:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                TextField(
                                  readOnly: true,
                                  enabled: false,
                                  controller: TextEditingController(
                                    text: selectedDate != null
                                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                        : "",
                                  ),
                                  onTap: () => _selectDate(context),
                                  decoration: InputDecoration(
                                    hintText: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                    suffixIcon: const Icon(Icons.calendar_month),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25,),

                                // Description
                                const Text(
                                  "Description:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),


                                TextField(
                                  controller: _incomeDescriptionController,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Description',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none
                                    ),
                                  ),
                                ),


                              ],
                            ),

                          ),
                        ),
                  ],
                ),
              ),
            ),

            // Button Rows
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpenseSelected || isIncomeSelected ? 100 : 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    if (isIncomeSelected)
                      Row(
                        children: [
                          //
                          // Cancel button
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const AdminDashboard();
                                  }),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6C63DC),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //
                          // Save Button
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: GestureDetector(
                              onTap: () {

                                setState(() {
                                  _isLoading = true;
                                });
                                _showLoadingDialog();
                                Future.delayed(const Duration(seconds: 3), () {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  _hideLoadingDialog();
                                  _expenseAmountController.clear();
                                  _expenseDescriptionController.clear();
                                  _expenseCustomerController.clear();
                                });

                                fireStoreService.addExpense(
                                  double.parse(_expenseAmountController.text.trim()),
                                  expenseSelectedCategory!,
                                  _expenseDescriptionController.text.trim(),
                                  _expenseCustomerController.text.trim(),
                                );
                                expenseSelectedCategory = null;
                              },
                              child: Container(
                                width: 100,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6D62F7),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    if (isExpenseSelected)
                      Row(
                        children: [
                          //
                          // Cancel button
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const AdminDashboard();
                                  }),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6C63DC),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //
                          // Save Button
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: GestureDetector(
                              onTap: () {


                                setState(() {
                                  _isLoading = true;
                                });

                                // show loading circle
                                _showLoadingDialog();

                                // after 3 seconds remove loading circle
                                Future.delayed(const Duration(seconds: 3), () {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  // remove loading circle
                                  _hideLoadingDialog();

                                  // clear data after saving in database
                                  _incomeAmountController.clear();
                                  _incomeDescriptionController.clear();
                                  _incomeCustomerController.clear();
                                });


                                // save data in database
                                fireStoreService.addIncome(
                                  double.parse(_incomeAmountController.text.trim()),
                                  incomeSelectedCategory!,
                                  _incomeDescriptionController.text.trim(),
                                  _incomeCustomerController.text.trim(),
                                );

                                // clear data after sending
                                incomeSelectedCategory = null;
                              },
                              child: Container(
                                width: 100,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6D62F7),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),

    );
  }
}
