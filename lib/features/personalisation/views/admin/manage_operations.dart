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
  int totalLayers = 0;
  int totalBroilers = 0;
  String _layerHintText = "Loading...";
  String _broilerHintText = "Loading...";

  // Layers Text fields controllers
  final _totalEggsCollectedController = TextEditingController();
  final _eggsWeightController = TextEditingController();
  final _totalLayersController = TextEditingController();
  final _layersDescriptionController = TextEditingController();
  final _deadLayersController = TextEditingController();

  // Layers Text fields controllers
  final _totalBroilersController = TextEditingController();
  final _soldBroilersController = TextEditingController();
  final _deadBroilersController = TextEditingController();
  final _slaughteredBroilersController = TextEditingController();
  final _broilersDescriptionController = TextEditingController();

  @override
  void dispose() {
    _totalEggsCollectedController.dispose();
    _eggsWeightController.dispose();
    _totalLayersController.dispose();
    _layersDescriptionController.dispose();
    _broilersDescriptionController.dispose();
    _deadBroilersController.dispose();
    _deadLayersController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // GET TOTAL LAYERS AND BROILERS
    _listenToLayerCount();
    _listenBroilerCount();
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
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  void _listenToLayerCount() {
    fireStoreService.getTotalLayers().listen((totalLayers) {
      setState(() {
        _layerHintText = '$totalLayers';
      });
    }).onError((error) {
      setState(() {
        _layerHintText = 'Error: $error';
      });
    });
  }

  void _listenBroilerCount() {
    fireStoreService.getTotalBroilers().listen((totalBroilers) {
      setState(() {
        _broilerHintText = '$totalBroilers';
      });
    }).onError((error) {
      setState(() {
        _broilerHintText = 'Error: $error';
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    // GET USER-NAME
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

            // EXPENSES AND INCOME BUTTON'S
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

                    // Layers button
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
                          color: isLayersSelected ? const Color(0xFF6D62F7) : Colors.white,
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

                    // Broilers Button
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
                          color: isBroilersSelected ? const Color(0xFF6D62F7) : Colors.white,
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

            const SizedBox(height: 25,),

            // INPUT FIELDS
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isBroilersSelected || isLayersSelected ? 750 : 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    // LAYERS INPUT FIELDS
                    if (isLayersSelected)
                      Padding(
                        padding: const EdgeInsets.only(left: 35, right: 20.0),
                        child: Container(
                          padding: const EdgeInsets.all(14.0),
                          width: 300,
                          height: 750,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9F9),
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

                              TextFormField(
                                controller: _totalLayersController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: _layerHintText,
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

                              // DEAD CHICKENS
                              const Text(
                                "Chicken Mortality Count:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // TODO: Save to Database/FireStore
                              TextFormField(
                                controller: _deadLayersController,
                                keyboardType: TextInputType.number,
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

                              const SizedBox(height: 25,),

                              // TOTAL EGGS COLLECTED
                              const Text(
                                "Eggs Collected:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextFormField(
                                controller: _totalEggsCollectedController,
                                keyboardType: TextInputType.number,
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

                              const SizedBox(height: 25,),

                              // EGGS SIZE TEXT-FIELD
                              const Text(
                                "Egg Size:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              DropdownButtonFormField<String>(
                                value: eggSizeSelected,
                                hint: const Text('Select Size'),
                                items: eggSizes.map((category) {
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
                                    eggSizeSelected = value;
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

                              // EGGS WEIGHT
                              const Text(
                                "Eggs Weight:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextFormField(
                                controller: _eggsWeightController,
                                decoration: InputDecoration(
                                  hintText: "0.0g",
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

                              // CURRENT DATE TEXT-FIELD
                              const Text(
                                "Date:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextFormField(
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

                              // DESCRIPTION
                              const Text(
                                "Description:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextFormField(
                                controller: _layersDescriptionController,
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

                    // BROILER INPUT FIELDS
                    if (isBroilersSelected)
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                        child: Container(
                          padding: const EdgeInsets.all(14.0),
                          width: 300,
                          height: 750,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // TOTAL BROILER CHICKENS
                              const Text(
                                "Total Broiler Chickens:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextFormField(
                                controller: _totalBroilersController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: _broilerHintText,
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

                              // SOLD CHICKENS
                              const Text(
                                "Sold Chickens:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextFormField(
                                controller: _soldBroilersController,
                                keyboardType: TextInputType.number,
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

                              const SizedBox(height: 25,),

                              // DEAD CHICKENS
                              const Text(
                                "Chicken Mortality Count:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // TODO: Save to Database/FireStore
                              TextFormField(
                                controller: _deadBroilersController,
                                keyboardType: TextInputType.number,
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

                              const SizedBox(height: 25,),


                              // NUMBER OF SLAUGHTERED CHICKENS
                              const Text(
                                "Slaughtered Chickens:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextFormField(
                                controller: _slaughteredBroilersController,
                                keyboardType: TextInputType.number,
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

                              const SizedBox(height: 25,),

                              // CURRENT DATE TEXT-FIELD
                              const Text(
                                "Date:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextFormField(
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

                              // DESCRIPTION
                              const Text(
                                "Description:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextFormField(
                                controller: _broilersDescriptionController,
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

            // BUTTON ROW
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isBroilersSelected || isLayersSelected ? 100 : 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    // LAYERS ROW BUTTONS
                    if (isLayersSelected)
                      Row(
                        children: [
                          // LAYERS CANCEL BUTTON
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

                          // LAYERS SAVE BUTTON
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
                                  _totalEggsCollectedController.clear();
                                  _totalLayersController.clear();
                                  _eggsWeightController.clear();
                                  _layersDescriptionController.clear();
                                  _deadLayersController.clear();
                                });

                                fireStoreService.addLayers(
                                  int.parse(_totalLayersController.text.trim()),
                                  int.parse(_totalEggsCollectedController.text.trim()),
                                  eggSizeSelected!,
                                  double.parse(_eggsWeightController.text.trim()),
                                  _layersDescriptionController.text.trim(),
                                  int.parse(_deadLayersController.text.trim()),
                                );
                                eggSizeSelected = null;
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

                    // BROILERS ROW BUTTONS
                    if (isBroilersSelected)
                      Row(
                        children: [

                          // BROILERS CANCEL BUTTON
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

                          // BROILERS SAVE BUTTON
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
                                  _totalBroilersController.clear();
                                  _soldBroilersController.clear();
                                  _slaughteredBroilersController.clear();
                                  _broilersDescriptionController.clear();
                                  _deadBroilersController.clear();
                                });


                                // save data in database
                                fireStoreService.addBroilers(
                                  int.parse(_totalBroilersController.text.trim()),
                                  int.parse(_soldBroilersController.text.trim()),
                                  int.parse(_slaughteredBroilersController.text.trim()),
                                  _broilersDescriptionController.text.trim(),
                                  int.parse(_deadBroilersController.text.trim()),
                                );
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
