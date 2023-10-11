import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../login_scree.dart';

registerUser(
  String username,
  String userEmail,
  String userContact,
  String userPassword,
) async {
  User? userId = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("users").doc(userId!.uid).set({
      'username': username,
      'userEmail': userEmail,
      'userContact': userContact,
      'createdDate': DateTime.now(),
      'userId': userId.uid,
    }).then((value) => {
          //Signout function
          FirebaseAuth.instance.signOut(),
          //jump to the login screen after registration completed
          Get.to(() => const LoginScreen())
        });
  } on FirebaseAuthException catch (e) {
    print("Error $e");
  }
}

//105 dekhi baki