import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'login_scree.dart';
import 'services/registration_services.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //calling getx
  //final controller = Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();
  bool _isSecurePassword = true;
  // TextEdit Controllers to send data  in firebase from  reg page
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //variable for retriving uid from  firebase
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
              child: Form(
            //form key for  form validation
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //back icon button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      iconSize: 25,
                      color: Colors.red,
                      splashColor: Colors.red),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 11, bottom: 15),
                  child: Center(
                    child: Lottie.asset(
                      "assets/animations/registration_page.json",
                      height: 170,
                      width: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Text(
                  "Register Now",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                //username text field
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(9)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: TextFormField(
                      //controler
                      controller: usernameController,

                      validator: (value) {
                        //validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        } else if (value.length <= 5) {
                          return "Username should be greate than 5 characters";
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Color(0xFFDA3340),
                          ),
                          border: InputBorder.none,
                          hintText: "Username"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Email TextField
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(9)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: TextFormField(
                      //validation
                      validator: (value) {
                        //validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Email';
                        } else if (!isValidEmail(value)) {
                          return 'Please enter a valid Email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      //controller
                      controller: emailController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Color(0xFFDA3340),
                          ),
                          border: InputBorder.none,
                          hintText: "Email"),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                //contact textfield
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(9)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: TextFormField(
                      //validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter contact number';
                        } else if (!_isValidPhoneNumber(value)) {
                          return "Please enter a valid contact number";
                        }
                        // else if (value.length != 10 || value.length != 9) {
                        //   return "Enter valid phone number";
                        // }
                        return null;
                      },

                      keyboardType: TextInputType.phone,
                      //controller
                      controller: contactController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.phone,
                            color: Color(0xFFDA3340),
                          ),
                          border: InputBorder.none,
                          hintText: "Contact"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //password textfield
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(9)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: TextFormField(
                      //validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        } else if (value.length < 6) {
                          return "Password length shoulb be greater than 6 letter";
                        }
                        return null;
                      },

                      //controller
                      controller: passwordController,
                      obscureText: _isSecurePassword,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.key,
                            color: Colors.red,
                          ),
                          suffixIcon: togglePassword(),
                          border: InputBorder.none,
                          hintText: "Password"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                //Register button
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: const Text(
                            "Register Account",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        color: const Color(0xFFEC5150),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        onPressed: () async {
                          // form validation
                          if (_formKey.currentState!.validate()) {
                            // _formKey.currentState!.save();
                            // RegistrationController.instance.registerUser(
                            //     controller.userEmail.text.trim(),
                            //     controller.password.text.trim());

                            var username = usernameController.text.trim();
                            var userEmail = emailController.text.trim();
                            var userContact = contactController.text.trim();
                            var userPassword = passwordController.text.trim();

                            //sending data to firebase
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                    email: userEmail,
                                    password: userPassword,
                                  )
                                  .then((value) => {
                                        registerUser(username, userEmail,
                                            userContact, userPassword),

                                        // pupup message
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "User Created Successfully !"))),
                                      });
                            } on FirebaseAuthException catch (_, ex) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Sorry, Something went wrong!!')),
                              );
                              print(ex);
                            }
                          }
                          ;

                          // child:
                        },
                      ),
                    ),
                  ],
                ),
                //const Spacer(),

                //Already have an account link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    //register button
                    TextButton(
                      onPressed: () {
                        Get.to(() => const LoginScreen());
                      },
                      child: const Text(
                        "Login",
                        style:
                            TextStyle(color: Color(0xFFDA3340), fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

//password hide/show
  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? const Icon((Icons.visibility))
          : const Icon(Icons.visibility_off),
      color: Colors.red,
    );
  }
}

//function to valid email address
bool isValidEmail(String email) {
  final RegExp regex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
    multiLine: false,
  );
  return regex.hasMatch(email);
}

// Function to validate a phone number
bool _isValidPhoneNumber(String phoneNumber) {
  final RegExp phoneNumberRegex = RegExp(r'^[0-9]{9,10}$');
  return phoneNumberRegex.hasMatch(phoneNumber);
}
