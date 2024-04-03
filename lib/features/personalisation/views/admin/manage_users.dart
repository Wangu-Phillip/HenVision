import 'package:flutter/material.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Users"),
        centerTitle:  true,
      ),

      body: const Column(

        /// TODO: Add user form in a dialogue
        /// TODO: Display users in a table formart with edit and delete icons
      ),
    );
  }
}
