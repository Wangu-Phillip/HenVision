import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {

    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("A password reset link has been sent to " +
                  _emailController.text),
            );
          });

      Navigator.pop(context); // Dismiss loading dialog
      
    } on FirebaseAuthException catch (e) {
      // print(e);
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message!.toString()),
            );
          });

      Navigator.pop(context); // Dismiss loading dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
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
                height: 40,
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

              // Email TextField
              TextField(
                controller: _emailController,
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
                height: 30,
              ),

              // Reset Password Button
              GestureDetector(
                onTap: resetPassword,
                child: Container(
                  width: 319,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5.0),
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
      ),
    );
  }
}
