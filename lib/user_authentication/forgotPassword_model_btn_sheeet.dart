import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forgot password/forgot_password_mail.dart';
import 'forgot password/forgot_password_phone_screen.dart';
import 'forgotPasswordBtnWidget.dart';

class ForgotPasswordScreen {
  static Future<dynamic> buildShowModelBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Make Selection!",
              style: TextStyle(
                  fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Select one of the options given below to rest your passwrod.",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // forgot password via email
            ForgetPasswordBtnWidget(
              onTap: () {
                Get.to(() => const ForgotPasswordMailScreen());
              },
              btnIcon: Icons.mail_lock_rounded,
              title: "Email",
              subTitle: "Reset via E-mail Verification",
            ),
            const SizedBox(
              height: 10,
            ),
            // forgot password via phone number
            ForgetPasswordBtnWidget(
              onTap: () {
                Get.to(() => const ForgotPasswordPhoneScreen());
              },
              btnIcon: Icons.mobile_friendly_rounded,
              title: "Phone Number",
              subTitle: "Reset via Phone Verification",
            ),
          ],
        ),
      ),
    );
  }
}
