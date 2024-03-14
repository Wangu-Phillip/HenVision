import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
   Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // TextField controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
     try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: emailController.text,
         password: passwordController.text,
       );
     } on FirebaseAuthException catch (error) {

     }

     // Pop the loading circle
     Navigator.pop(context);

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
                height: 100,
              ),

              // Place Logo here
              const Text(
                "Logo Area",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),

              const SizedBox(
                height: 76,
              ),

              // Username TextField
              TextField(
                controller: emailController,
                style: const TextStyle(
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // Password TextField
              TextField(
                controller: passwordController,
                style: const TextStyle(
                  fontSize: 13,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // Remember me CheckBox
              const Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text(
                    "Remember me",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 50,
              ),

              // Login Button
              GestureDetector(
                onTap: signUserIn,
                child: Container(
                  width: 319,
                  height: 54,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5.0),
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
                height: 25,
              ),

              // forgot password
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
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
