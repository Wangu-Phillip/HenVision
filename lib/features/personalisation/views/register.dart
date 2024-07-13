import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // TextField controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isChecked = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                "Register",
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
                controller: usernameController,
                style: const TextStyle(
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  labelText: "Username/Business name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty ) {
                    return 'Please enter a Username or Business name';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 15,
              ),

              // Email TextField
              TextFormField(
                controller: emailController,
                style: const TextStyle(
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  labelText: "Email",
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
                  labelText: "Password",
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

              const SizedBox(height: 15,),

              // CONFIRM PASSWORD TEXT-FIELD
              TextFormField(
                controller: confirmPasswordController,
                style: const TextStyle(
                  fontSize: 13,
                ),
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
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
                  } else if(confirmPasswordController.text != passwordController.text) {
                    return 'Password\'s must match';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 15,
              ),

              // Login Button
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 319,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              // LOGIN
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {

                  },
                  child: const Text(
                    "Already have an account? Login",
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
}
