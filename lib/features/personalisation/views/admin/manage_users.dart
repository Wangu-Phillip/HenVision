import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/drawer.dart';
import '../../services/firestore_service.dart';
import 'admin_dashboard.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  // Initialize firestore Service
  final FireStoreService fireStoreService = FireStoreService();

  // get user name
  final user = FirebaseAuth.instance.currentUser!;

  String? roleSelectedCategory;
  
  // buttons checker
  bool isViewUsersSelected = true;
  bool isAddUsersSelected = false;

  // loading checker
  bool _isLoading = false;

  // Text fields controllers
  final _firstnameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _userEmailController = TextEditingController();

  @override
  void dispose() {
    _firstnameController.dispose();
    _surnameController.dispose();
    _userEmailController.dispose();

    super.dispose();
  }

  List<String> roles = [
    'Farmer',
    'Admin',
  ];
  
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Manage Users"),
        centerTitle: true,
      ),

      // Side bar menu
      drawer: SidebarMenu(user: user),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),

            // USER LIST & ADD USER BUTTONS
            Center(
              child: Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 0.2,
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
                    // View Users button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isViewUsersSelected = true;
                          isAddUsersSelected = false;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isViewUsersSelected
                              ? Color(0xFF6D62F7)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Users",
                          style: TextStyle(
                            color: isViewUsersSelected
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    // Add users Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isViewUsersSelected = false;
                          isAddUsersSelected = true;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isAddUsersSelected
                              ? Color(0xFF6D62F7)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Add User",
                          style: TextStyle(
                            color: isAddUsersSelected
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // Input Fields
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: isViewUsersSelected || isAddUsersSelected ? 500 : 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (isViewUsersSelected)
                      // users list
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 300,
                          height: 500,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              return ListView.builder(
                                itemCount: documents.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> data =
                                  documents[index].data()
                                  as Map<String, dynamic>;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 343,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          //
                                          BoxShadow(
                                            color: Colors.grey.shade500,
                                            offset: const Offset(0, 0.5),
                                            blurRadius: 0.5,
                                            spreadRadius: 0.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ListTile(
                                        // title: Text(data['name'] +' ' + data['surname']),
                                        subtitle: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                data['name'] +' ' + data['surname'],
                                              style: TextStyle(
                                                fontSize: 19,
                                              ),
                                            ),
                                            Text(data['email']),
                                          ],
                                        ),
                                        trailing: GestureDetector(
                                          onTap: () {

                                            setState(() {
                                              _isLoading = true;
                                            });
                                            _showLoadingDialog();
                                            Future.delayed(const Duration(seconds: 2), () {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              _hideLoadingDialog();
                                            });

                                            fireStoreService.deleteUser(data['email']);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 15.0),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red.shade500,
                                            ),
                                          ),
                                        ),
                                        // Add more fields as needed
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),

                    if (isAddUsersSelected)
                      // Add users
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(14.0),
                          width: 300,
                          height: 450,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // user name text & text field
                              const Text(
                                "First Name:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // User name
                              TextField(
                                controller: _firstnameController,
                                decoration: InputDecoration(
                                  hintText: "John",
                                  filled: true,
                                  fillColor: Colors.white,
                                  //border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 25,
                              ),

                              // Surname text field
                              const Text(
                                "Last Name:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // Surname textzxfield
                              TextField(
                                controller: _surnameController,
                                decoration: InputDecoration(
                                  hintText: "Dory",
                                  filled: true,
                                  fillColor: Colors.white,
                                  //border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 25,
                              ),

                              // Role text
                              const Text(
                                "Role:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              DropdownButtonFormField<String>(
                                value: roleSelectedCategory,
                                hint: const Text('Choose User Role'),
                                items: roles.map((category) {
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
                                    roleSelectedCategory = value;
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

                              const SizedBox(
                                height: 25,
                              ),

                              // User email text
                              const Text(
                                "Email:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // username textfield
                              TextField(
                                controller: _userEmailController,
                                decoration: InputDecoration(
                                  hintText: "johndory@example.com",
                                  filled: true,
                                  fillColor: Colors.white,
                                  //border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
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

            const SizedBox(
              height: 25,
            ),

            // Button Rows
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: isViewUsersSelected || isAddUsersSelected ? 100 : 0,
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    if (isAddUsersSelected)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Cancel button
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 30.0),
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

                          // Save Button
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
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

                                  // clear all textfields
                                  _firstnameController.clear();
                                  _surnameController.clear();
                                  _userEmailController.clear();
                                });

                                // Saving a user to database
                                fireStoreService.addUser(
                                  _firstnameController.text.trim(),
                                  _surnameController.text.trim(),
                                  roleSelectedCategory!,
                                  _userEmailController.text.trim(),
                                );

                                // clear data after sending
                                roleSelectedCategory = null;
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
