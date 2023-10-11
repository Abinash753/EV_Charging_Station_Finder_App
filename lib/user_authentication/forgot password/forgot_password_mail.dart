import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../login_scree.dart';

class ForgotPasswordMailScreen extends StatefulWidget {
  const ForgotPasswordMailScreen({super.key});

  @override
  State<ForgotPasswordMailScreen> createState() =>
      _ForgotPasswordMailScreenState();
}

class _ForgotPasswordMailScreenState extends State<ForgotPasswordMailScreen> {
  TextEditingController forgetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar
      appBar: AppBar(
        title: const Text("Reset Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            const SizedBox(
              height: 40,
            ),
            //image animation
            Center(
              child: Lottie.asset(
                "assets/animations/Email_Reset.json",
                height: 200,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            //body text
            const Text(
              "Reset Your Password by Entering E-mail Address",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 50,
            ),
            //input field for email
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(9)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                child: TextFormField(
                  //controller
                  controller: forgetPasswordController,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.red,
                      ),
                      border: InputBorder.none,
                      hintText: "Email"),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            //button to reset
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    color: const Color(0xFFEC5150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onPressed: () async {
                      //resetting forgot password using user email
                      var forgotEmail = forgetPasswordController.text.trim();
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: forgotEmail)
                            .then((value) => {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Email Sent !"))),
                                });
                        Get.off(() => const LoginScreen());
                      } on FirebaseAuthException catch (e) {
                        print("Error $e");
                      }

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const OPTScreen()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
