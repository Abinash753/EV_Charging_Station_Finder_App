import 'package:custom_signin_buttons/button_data.dart';
import 'package:custom_signin_buttons/button_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen.dart';
import 'forgotPassword_model_btn_sheeet.dart';
import 'registration_screen.dart';
import 'services/google_signin_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final GoogleSingIn _googleSingIn = GoogleSingIn();
  get icon => null;
  bool _isSecurePassword = true;

  TextEditingController loginEmailCOntroller = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Center(
                  child: Lottie.asset(
                    "assets/animations/welcome_page.json",
                    height: 300,
                    width: 330,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text(
                "Login Now",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //text
              const Text(
                "Please enter the details below to continue",
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              //email text field
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(9)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                  child: TextFormField(
                    //controller
                    controller: loginEmailCOntroller,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.red,
                        ),
                        border: InputBorder.none,
                        hintText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //password textfield
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(9)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                  child: TextFormField(
                    //controller
                    controller: loginPasswordController,
                    obscureText: _isSecurePassword,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.key,
                          color: Color(0xFFDA3340),
                        ),
                        suffixIcon: togglePassword(),
                        hintText: "Password"),
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),

              //forgot password
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      //BottomSheet for forgot password UI
                      ForgotPasswordScreen.buildShowModelBottomSheet(context);
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xFFDA3340), fontSize: 17),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              //login button
              Row(
                children: [
                  Expanded(
                      child: MaterialButton(
                    color: Color(0xFFEC5150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onPressed: () async {
                      if (UserCredential == null) {
                        showLoadingDialog(context,
                            duration: Duration(seconds: 4));
                      }
                      // showLoadingDialog(context,
                      //     duration: Duration(seconds: 4));
                      // showDialog(
                      //   barrierDismissible: false,
                      //     context: context,
                      //     builder: (context) {
                      //       return const Center(
                      //           child: CircularProgressIndicator());
                      //     });

                      var loginEmail = loginEmailCOntroller.text.trim();
                      var loginPassword = loginPasswordController.text.trim();

                      //login function
                      try {
                        final User? firebaseUser = (await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: loginEmail, password: loginPassword))
                            .user;

                        //  Navigator.of(context).pop();
                        //navigate to home screen if the condition met
                        if (firebaseUser != null) {
                          Get.to(() => const HomeScreen());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Username and Password not valid !!')));
                          //print("Check Email and password");
                        }
                      } on FirebaseAuthException catch (e) {
                        print(e);

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Sorry, Something went wrong!!')));
                      }

                      try {} on FirebaseAuthException catch (e) {
                        // print("Error $e");
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )),
                ],
              ),
              //const Spacer(),
              const SizedBox(
                height: 2,
              ),
              //don't have an account link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  //register button
                  TextButton(
                    onPressed: () {
                      Get.to(() => const RegistrationScreen());
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Color(0xFFDA3340), fontSize: 18),
                    ),
                  ),
                ],
              ),

              //Signin with google
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                    button: Button.Google,
                    height: 50,
                    width: 300,
                    borderRadius: 30,
                    textSize: 20,
                    iconSize: 50,
                    text: "Signin with Google",
                    splashColor: Colors.red,
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  //
  void showLoadingDialog(BuildContext context, {required Duration duration}) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dialog from being dismissed by tapping outside
      builder: (context) {
        Future.delayed(duration, () {
          Navigator.of(context)
              .pop(); // Close the dialog after the specified duration
        });

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? Icon((Icons.visibility))
          : Icon(Icons.visibility_off),
      color: Colors.red,
    );
  }
}
