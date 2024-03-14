import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            const SizedBox(
              height: 100,
            ),

            // Forgot Password Heading
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Please enter your email to reset the password.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            const SizedBox(
              height: 72,
            ),

            // Textfield label
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Your Email:",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // Email Textfield
            TextField(
              style: const TextStyle(
                fontSize: 13,
              ),
              decoration: InputDecoration(
                hintText: "Enter your email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),

            const SizedBox(
              height: 53,
            ),

            // Reset Password Button
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
                  "Reset Password",
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
