import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
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

            // Username Textfield
            TextField(
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

            // Password Textfield
            TextField(
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
    );
  }
}
