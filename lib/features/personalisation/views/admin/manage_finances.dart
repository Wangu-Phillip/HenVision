import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/drawer.dart';
import '../../services/firestore_service.dart';

class ManageFinances extends StatefulWidget {
  const ManageFinances({super.key});

  @override
  State<ManageFinances> createState() => _ManageFinancesState();
}

class _ManageFinancesState extends State<ManageFinances> {

  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  // buttons checker
  bool isIncomeSelected = false;
  bool isExpenseSelected = false;

  //
  DateTime? selectedDate;
  String? selectedCategory;

  // Text fields controllers
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  // categories list
  List<String> categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
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
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.3,
                ),
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
                        color: isIncomeSelected ? Color(0xFF6D62F7) : Colors.white,
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
                        color: isExpenseSelected ? Color(0xFF6D62F7) : Colors.white,
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

            SizedBox(height: 25,),

            // Input Fields
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: isExpenseSelected || isIncomeSelected ? 450 : 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    // Expenses input fields
                    if (isIncomeSelected)
                        Padding(
                          padding: const EdgeInsets.only(left: 35, right: 20.0),
                          child: Container(
                            padding: EdgeInsets.all(14.0),
                            width: 300,
                            height: 450,
                            decoration: BoxDecoration(
                              color: Color(0xFFF8F9F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // Amount text & text field
                                const Text(
                                  "Amount:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                TextField(
                                  controller: _amountController,
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

                                SizedBox(height: 25,),

                                // category text field
                                const Text(
                                  "Category:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                            DropdownButtonFormField<String>(
                              value: selectedCategory,
                              hint: Text('Select Category'),
                              items: categories.map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                      category,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value;
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),


                                SizedBox(height: 25,),

                                // Date & text field
                                const Text(
                                  "Date:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                TextField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: selectedDate != null
                                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                        : "",
                                  ),
                                  onTap: () => _selectDate(context),
                                  decoration: InputDecoration(
                                    hintText: "Select Date",
                                    suffixIcon: Icon(Icons.calendar_month),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 25,),

                                // Description
                            const Text(
                              "Description:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),


                            TextField(
                              controller: _descriptionController,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: 'Enter Description',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                            padding: EdgeInsets.all(14.0),
                            width: 300,
                            height: 450,
                            decoration: BoxDecoration(
                              color: Color(0xFFF8F9F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // Amount text & text field
                                const Text(
                                  "Amount (Profit/Loss):",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                TextField(
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

                                SizedBox(height: 25,),

                                // category text field
                                const Text(
                                  "Category:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                DropdownButtonFormField<String>(
                                  value: selectedCategory,
                                  hint: Text('Select Category'),
                                  items: categories.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCategory = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),


                                SizedBox(height: 25,),

                                // Date & text field
                                const Text(
                                  "Date:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                TextField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: selectedDate != null
                                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                        : "",
                                  ),
                                  onTap: () => _selectDate(context),
                                  decoration: InputDecoration(
                                    hintText: "Select Date",
                                    suffixIcon: Icon(Icons.calendar_month),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 25,),

                                // Description
                                const Text(
                                  "Description:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),


                                TextField(
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Description',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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

            SizedBox(height: 25,),

            // Button Rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // Cancel button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF6C63DC),
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

                // Save Button
                GestureDetector(
                  onTap: () {
                    fireStoreService.addExpense(
                      double.parse(_amountController.text.trim()),
                      selectedCategory!,
                      _descriptionController.text.trim(),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF6D62F7),
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


              ],
            ),


          ],
        ),
      ),

    );
  }
}
