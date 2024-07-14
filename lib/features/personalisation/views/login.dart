import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hen_vision/features/personalisation/views/forgot_password.dart';
import 'package:hen_vision/features/personalisation/views/register.dart';

class Login extends StatefulWidget {
   const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // TextField controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isChecked = false;
  bool obscurePassword = true;

  // User auth
   void signUserIn() async {

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

     // try sign in
     try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: emailController.text.trim(), // Trim whitespace
         password: passwordController.text.trim(),
       );
       Navigator.pop(context); // Dismiss loading dialog
     } on FirebaseAuthException catch (e) {
       Navigator.pop(context); // Dismiss loading dialog

       if (e.code == 'user-not-found') {
         wrongEmailMessage();
       } else if (e.code == 'wrong-password') {
         wrongPasswordMessage();
       } else {
         // Handle other errors generically
         genericErrorMessage(e.message!);
       }
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),

              // Place Logo here
              const Text(
                "LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              // Username TextField
              TextFormField(
                controller: emailController,
                style: const TextStyle(
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty ) {
                    return 'Please enter am email';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 15,
              ),

              // PASSWORD TEXT-FIELD
              TextFormField(
                controller: passwordController,
                style: const TextStyle(
                  fontSize: 13,
                ),
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty ) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 10,
              ),

              // REMEMBER ME CHECKBOX
               Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        isChecked = newValue!;
                      });
                    },
                    activeColor: Colors.black,
                    checkColor: Colors.white,
                  ),

                  const Text(
                    "Remember me",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              // Login Button
              GestureDetector(
                onTap: signUserIn,
                child: Container(
                  width: 319,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              // FORGOT PASSWORD
              Container(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) =>
                         const ForgotPassword(),),
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              // REGISTER
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => const Register()),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
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
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Incorrect email"),
          content: const Text("The user could not be found. Please check the email and try again."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Incorrect password"),
          content: const Text("The password you entered is incorrect. Please try again."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void genericErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("An error occurred"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
