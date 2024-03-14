import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          children: [

            const SizedBox(
              height: 100,
            ),

            // Validate email - Text
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Create a new password",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            const SizedBox(
              height: 103,
            ),

            // New-password label
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "New password",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // New-password Textfield
            TextField(
              style: const TextStyle(
                fontSize: 13,
              ),
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {}, 
                    icon: Icon(Icons.visibility_off_outlined),
                ),
                hintText: "Enter your new password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // Re-enter password label
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Confirm password",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // Confirm Password Textfield
            TextField(
              style: const TextStyle(
                fontSize: 13,
              ),
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.visibility_off_outlined),
                ),
                hintText: "Re-enter Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),

            const SizedBox(
              height: 53,
            ),

            // Change Password Button
            Container(
              width: 319,
              height: 54,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  "Change Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
