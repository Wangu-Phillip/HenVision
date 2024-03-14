import 'package:flutter/material.dart';

class ValidateEmail extends StatelessWidget {
  const ValidateEmail({super.key});

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

            // Validate email - Text
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Check your email",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            // Code sent - Text
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "We sent a reset link to example@gmail.com",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            const SizedBox(
              height: 31,
            ),

            // Enter 4 digit - Text
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Enter 4 digit code mentioned in the email.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            const SizedBox(
              height: 72,
            ),

            // Input code from email
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black38,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    child: const Text(
                      "_",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  SizedBox(width: 19,),

                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black38,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    child: const Text(
                      "_",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  SizedBox(width: 19,),

                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black38,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    child: const Text(
                      "_",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  SizedBox(width: 19,),

                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black38,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    child: const Text(
                      "_",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  SizedBox(width: 19,),

                ],
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
                  "Verify Code",
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
                child: const Row(
                  children: [
                    Text(
                      "Haven\'t got the email yet?",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox( width: 10,),

                    Text(
                      "Resend code",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
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
