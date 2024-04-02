import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/drawer.dart';
import '../../services/firestore_service.dart';
import 'admin_dashboard.dart';

class ManageOperations extends StatefulWidget {
  const ManageOperations({super.key});

  @override
  State<ManageOperations> createState() => _ManageOperationsState();
}

class _ManageOperationsState extends State<ManageOperations> {

  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  // buttons checker
  bool isLayersSelected = true;
  bool isBroilersSelected = false;

  // loading checker
  bool _isLoading = false;

  //
  DateTime? selectedDate;
  String? eggSizeSelected;

  // Layers Text fields controllers
  final _totalEggsCollectedController = TextEditingController();
  final _eggsWeightController = TextEditingController();
  final _totalLayersController = TextEditingController();
  final _layersDescriptionController = TextEditingController();

  // Layers Text fields controllers
  final _totalBroilersController = TextEditingController();
  final _soldBroilersController = TextEditingController();
  final _slaughteredBroilersController = TextEditingController();
  final _broilersDescriptionController = TextEditingController();

  @override
  void dispose() {
    _totalEggsCollectedController.dispose();
    _eggsWeightController.dispose();
    _totalLayersController.dispose();
    _layersDescriptionController.dispose();
    _broilersDescriptionController.dispose();

    super.dispose();
  }

  // Egg sizes list
  List<String> eggSizes = [
    'Small',
    'Medium',
    'Large',
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
        return Center(
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
        title: const Text("Manage Operations"),
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
                          isBroilersSelected = false;
                          isLayersSelected = true;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isLayersSelected ? Color(0xFF6D62F7) : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Layers",
                          style: TextStyle(
                            color: isLayersSelected ? Colors.white : Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    // Income Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isBroilersSelected = true;
                          isLayersSelected = false;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isBroilersSelected ? Color(0xFF6D62F7) : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Broilers",
                          style: TextStyle(
                            color: isBroilersSelected ? Colors.white : Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),

            SizedBox(height: 25,),

            // Input Fields
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: isBroilersSelected || isLayersSelected ? 550 : 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    // Expenses input fields
                    if (isLayersSelected)
                      Padding(
                        padding: const EdgeInsets.only(left: 35, right: 20.0),
                        child: Container(
                          padding: EdgeInsets.all(14.0),
                          width: 300,
                          height: 550,
                          decoration: BoxDecoration(
                            color: Color(0xFFF8F9F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Total Layer chickens
                              const Text(
                                "Total Layer Chickens:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextField(
                                controller: _totalLayersController,
                                decoration: InputDecoration(
                                  hintText: "0",
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

                              // Total eggs collected
                              const Text(
                                "Eggs Collected:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextField(
                                controller: _totalEggsCollectedController,
                                decoration: InputDecoration(
                                  hintText: "0",
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

                              // Eggs Size text field
                              const Text(
                                "Egg Size:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              DropdownButtonFormField<String>(
                                value: eggSizeSelected,
                                hint: Text('Select Size'),
                                items: eggSizes.map((category) {
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
                                    eggSizeSelected = value;
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

                              // Eggs weight
                              const Text(
                                "Eggs Weight:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextField(
                                controller: _eggsWeightController,
                                decoration: InputDecoration(
                                  hintText: "0",
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

                              // Description
                              const Text(
                                "Description:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),


                              TextField(
                                controller: _layersDescriptionController,
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
                    if (isBroilersSelected)
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                        child: Container(
                          padding: EdgeInsets.all(14.0),
                          width: 300,
                          height: 550,
                          decoration: BoxDecoration(
                            color: Color(0xFFF8F9F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Total Broiler chickens
                              const Text(
                                "Total Broiler Chickens:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextField(
                                controller: _totalBroilersController,
                                decoration: InputDecoration(
                                  hintText: "0",
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

                              // Sold chickens
                              const Text(
                                "Sold Chickens:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextField(
                                controller: _soldBroilersController,
                                decoration: InputDecoration(
                                  hintText: "0",
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

                              // Number of Slaughtered chickens
                              const Text(
                                "Slaughtered Chickens:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextField(
                                controller: _slaughteredBroilersController,
                                decoration: InputDecoration(
                                  hintText: "0",
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

                              // Description
                              const Text(
                                "Description:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),


                              TextField(
                                controller: _broilersDescriptionController,
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

            // Button Rows
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: isBroilersSelected || isLayersSelected ? 100 : 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    if (isLayersSelected)
                      Row(
                        children: [
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
                          ),
                          // Save Button
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: GestureDetector(
                              onTap: () {

                                setState(() {
                                  _isLoading = true;
                                });
                                _showLoadingDialog();
                                Future.delayed(Duration(seconds: 3), () {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  _hideLoadingDialog();
                                  _totalEggsCollectedController.clear();
                                  _totalLayersController.clear();
                                  _eggsWeightController.clear();
                                  _layersDescriptionController.clear();
                                });

                                fireStoreService.addLayers(
                                  int.parse(_totalLayersController.text.trim()),
                                  int.parse(_totalEggsCollectedController.text.trim()),
                                  eggSizeSelected!,
                                  double.parse(_eggsWeightController.text.trim()),
                                  _layersDescriptionController.text.trim(),
                                );
                                eggSizeSelected = null;
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
                          ),
                        ],
                      ),

                    if (isBroilersSelected)
                      Row(
                        children: [
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
                          ),

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
                                Future.delayed(Duration(seconds: 3), () {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  // remove loading circle
                                  _hideLoadingDialog();

                                  // clear data after saving in database
                                  _totalBroilersController.clear();
                                  _soldBroilersController.clear();
                                  _slaughteredBroilersController.clear();
                                  _broilersDescriptionController.clear();
                                });


                                // save data in database
                                fireStoreService.addBroilers(
                                  int.parse(_totalBroilersController.text.trim()),
                                  int.parse(_soldBroilersController.text.trim()),
                                  int.parse(_slaughteredBroilersController.text.trim()),
                                  _broilersDescriptionController.text.trim(),
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
