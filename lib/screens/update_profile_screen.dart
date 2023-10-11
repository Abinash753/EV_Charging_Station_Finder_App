import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'profile_screen.dart';

class UpdateUserProfile extends StatefulWidget {
  const UpdateUserProfile({super.key});

  @override
  _UpdateUserProfileState createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userContactController = TextEditingController();

  String _userId = '';

  @override
  void initState() {
    super.initState();
    // Initialize Firebase and retrieve user ID
    _initializeFirebase();
  }

  void _initializeFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _userId = user!.uid;
    });

    // Retrieve user information from Firestore and set the controllers
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(_userId).get();
    if (userSnapshot.exists) {
      _userNameController.text = userSnapshot['username'] ?? "N/A";
      _userEmailController.text = userSnapshot['userEmail'] ?? "N/A";
      _userContactController.text = userSnapshot['userContact'] ?? "N/A";
    }
  }

  void _updateUserInfo() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_userId)
            .update({
          'username': _userNameController.text,
          'userEmail': _userEmailController.text,
          'userContact': _userContactController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User information updated successfully')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating user information')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.3),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //edit icon
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image(
                          image: AssetImage(
                            "assets/icons/edit_user_profile_icon.png",
                          ),
                        ),
                      ),
                      Text(
                        "Edit User Info",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(9)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                    child: TextFormField(
                      //controler
                      controller: _userNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xFFDA3340),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
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
                      controller: _userEmailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Color(0xFFDA3340),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //contact textfield
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(9)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                    child: TextFormField(
                      //controller
                      controller: _userContactController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter contact number';
                        }
                        return null;
                      },

                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: Color(0xFFDA3340),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                //update button
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 140,
                      child: MaterialButton(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90),
                          ),
                          onPressed: () {
                            _updateUserInfo();
                            Get.to(() => ProfileScreen());
                          },
                          child: const Text(
                            "Update User",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    //cancle button
                    SizedBox(
                      height: 50,
                      width: 120,
                      child: MaterialButton(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90),
                          ),
                          onPressed: () {
                            cancleEditUser();
                            Get.to(() => ProfileScreen());
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cancleEditUser() {
    _userNameController.text = "";
    _userEmailController.text = "";
    _userContactController.text = "";
  }
}
