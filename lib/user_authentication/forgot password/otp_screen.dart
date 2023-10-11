import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OPTScreen extends StatelessWidget {
  const OPTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar
      appBar: AppBar(
        title: const Text("OPT Screen"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //title text
            const Text(
              "Code",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            ),
            //text
            const Text(
              "VERIFICATION",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            //text
            const Text(
              "Enter the verification code sent at",
              style: TextStyle(fontSize: 20),
            ),
            //email
            const Text("abinashupreti1237@gmail.com",
                style: TextStyle(fontSize: 20)),
            const SizedBox(
              height: 20,
            ),
            //otp textfield
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.12),
              filled: true,
            ),
            const SizedBox(
              height: 30,
            ),
            //next button
            Row(
              children: [
                Expanded(
                    child: MaterialButton(
                  color: const Color(0xFFEC5150),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (context)=>));
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
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
