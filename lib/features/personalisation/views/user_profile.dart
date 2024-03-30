import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/common/widgets/drawer.dart';

class UserProfile extends StatelessWidget {

  // get user name
  final user = FirebaseAuth.instance.currentUser!;
  UserProfile({
    super.key,
    required user,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),

      // Sidebar menu
      drawer: SidebarMenu(user: user),

      body: Column(
        children: [

          // User profile picture
          const Center(
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 45,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 5),

          // username
          Text(
              "${user.email}",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0),
            child: Divider(
              height: 50,
              thickness: 0.3,

            ),
          ),

          const SizedBox(height: 20),

          // user information
          Container(
            width: 312,
            height: 107,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                //
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(0, 4),
                  blurRadius: 4.0,
                  spreadRadius: 0.0,
                ),

              ]
            ),

            child: const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 10),
              child: Column(
                children: [

                  // set notifications ON/OFF
                  Row(
                    children: [
                      Text("Edit Profile Information"),

                      SizedBox(width: 90,),

                      Icon(
                          Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.blue,
                      ),
                    ],
                  ),

                  SizedBox(height: 5,),

                  // set notifications ON/OFF
                  Row(
                    children: [
                      Text("Notifications"),

                      SizedBox(width: 150,),

                      /// Todo: Add navigation to edit profile information
                      Text(
                          "ON",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5,),

                  // change language
                  Row(
                    children: [
                      Text("Language"),

                      SizedBox(width: 150,),

                      /// Todo: Add onTap Function to display the language options
                      Text(
                        "English",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          // system settings
          Container(
            width: 312,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(0, 4.0),
                    blurRadius: 4.0,
                    spreadRadius: 0.0,
                  ),
                ]
            ),

            child: const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 8.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 8,),

                  // Security options
                  Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Security"),

                      SizedBox(width: 175,),

                      /// Todo: Add navigation to edit security settings
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.blue,
                      ),
                    ],
                  ),

                  SizedBox(height: 5,),

                  // Set Theme
                  Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Theme"),

                      SizedBox(width: 150,),

                      /// Todo: Add navigation to edit themes
                      Text(
                        "Light Mode",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Privacy settings
          Container(
            width: 312,
            height: 107,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(0, 4.0),
                    blurRadius: 4.0,
                    spreadRadius: 0.0,
                  ),
                ]
            ),

            child: const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 10.0),
              child: Column(

                children: [

                  SizedBox(height: 8,),

                  // Help and support
                  Row(
                    children: [
                      Text("Help & Support"),

                      SizedBox(width: 150.0,),

                      /// Todo: Add navigation to read on help and support
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.blue,
                      ),
                    ],
                  ),

                  SizedBox(height: 5,),

                  // Contact us
                  Row(
                    children: [
                      Text("Contact us"),

                      SizedBox(width: 177.0,),

                      /// Todo: Add navigation to contact us information
                      Icon(
                        Icons.phone_enabled_rounded,
                        size: 15,
                        color: Colors.blue,
                      ),
                    ],
                  ),

                  SizedBox(height: 5,),

                  // Read privacy policy
                  Row(
                    children: [
                      Text("Privacy policy"),

                      SizedBox(width: 158.0,),

                      /// Todo: Add navigation to read on privacy and policy
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.blue,
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
