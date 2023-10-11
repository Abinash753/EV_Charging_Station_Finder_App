import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'otp_screen.dart';

class ForgotPasswordPhoneScreen extends StatefulWidget {
  const ForgotPasswordPhoneScreen({super.key});

  @override
  State<ForgotPasswordPhoneScreen> createState() =>
      _ForgotPasswordMailScreenState();
}

class _ForgotPasswordMailScreenState extends State<ForgotPasswordPhoneScreen> {
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
                "assets/animations/phone_verification.json",
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            //body text
            const Text(
              "Reset Your Password by Entering phone number",
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
                        Icons.phone,
                        color: Colors.red,
                      ),
                      border: InputBorder.none,
                      hintText: "Phone Number"),
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
                    color: Color(0xFFEC5150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onPressed: () {
                      // verifyPhoneNumber();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OPTScreen()));
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
//   Future<void> verifyPhoneNumber({
//   String? phoneNumber,
//   PhoneMultiFactorInfo? multiFactorInfo,
//   required PhoneVerificationCompleted verificationCompleted,
//   required PhoneVerificationFailed verificationFailed,
//   required PhoneCodeSent codeSent,
//   required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
//   @visibleForTesting String? autoRetrievedSmsCodeForTesting,
//   Duration timeout = const Duration(seconds: 30),
//   int? forceResendingToken,
//   MultiFactorSession? multiFactorSession,
// }) {
//   assert(
//     phoneNumber != null || multiFactorInfo != null,
//     'Either phoneNumber or multiFactorInfo must be provided.',
//   );
//   return _delegate.verifyPhoneNumber(
//     phoneNumber: phoneNumber,
//     multiFactorInfo: multiFactorInfo,
//     timeout: timeout,
//     forceResendingToken: forceResendingToken,
//     verificationCompleted: verificationCompleted,
//     verificationFailed: verificationFailed,
//     codeSent: codeSent,
//     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//     // ignore: invalid_use_of_visible_for_testing_member
//     autoRetrievedSmsCodeForTesting: autoRetrievedSmsCodeForTesting,
//     multiFactorSession: multiFactorSession,
//   );
// }
}
