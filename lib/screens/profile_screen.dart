import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../user_authentication/login_scree.dart';
import 'profile_menu.dart';
import 'update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();

  // void logoutFunction() {}
}

class _ProfileScreenState extends State<ProfileScreen> {
  //image picker
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  getProfileIMage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  //upload  image onto  firebase
  // uploadImage(File image) async {
  //   String imageUrl = "";
  //   String fileName = Path.basename(image.path);
  //   var reference = FirebaseStorage.instance.ref().child("users/$fileName");
  //   UploadTask uploadTask = reference.putFile(image);
  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  //   await taskSnapshot.ref.getDownloadURL().then((value) => {
  //     imageUrl = value;
  //     print("downloaded url $imageUrl");
  //   });
  //   return imageUrl;
  // }
  //upload image into firebase
  // Future<String> uploadImage1(File image) async {
  //   String imageUrl = "";
  //   String fileName = path.basename(image.path);
  //   var reference = FirebaseStorage.instance.ref().child("users/$fileName");
  //   UploadTask uploadTask = reference.putFile(image);
  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  //   await taskSnapshot.ref.getDownloadURL().then((value) => {
  //         imageUrl = value,
  //         print("downloaded url _______________________ $imageUrl"),
  //       });
  //   return imageUrl;
  // }

//__________________________________________________
  // storeUserInfo() async {
  //   String url = await uploadImage1(selectedImage!);
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   FirebaseFirestore.instance.collection("users").doc(uid).set({'image': url});
  // }

  // Uint8List? _image;
  // //select user image function
  // void selectImage() async {
  //   Uint8List img = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _image = img;
  //   });
  // }
  Map<String, dynamic> _userInfo = {};

  @override
  void initState() {
    super.initState();
    fetchUserInfo().then((userInfo) {
      setState(() {
        _userInfo = userInfo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "User Profile",
          style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.3),
        ),
        actions: [
          //Dark/light mode icon
          IconButton(
            onPressed: () {},
            icon:
                Icon(/*isDark ? LineAwesomeIcons.sun :*/ LineAwesomeIcons.moon),
            iconSize: 33,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Stack(
                  children: [
                    // profile image
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          getProfileIMage(ImageSource.gallery);
                        },
                        child: selectedImage == null
                            ? Container(
                                width: 120,
                                height: 120,
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                                child: const Center(
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : Container(
                                width: 120,
                                height: 120,
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(selectedImage!),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                                child: const Center(),
                              ),
                      ),
                    ),
                    //upload image icon

                    // InkWell(
                    //   onTap: () {
                    //     getProfileIMage(ImageSource.camera);
                    //   },
                    //   child:selectedImage != null? CircleAvatar(
                    //     radius: 64,
                    //     backgroundImage: MemoryImage(_image!),
                    //   ):
                    //   const CircleAvatar(
                    //     radius: 64,
                    //     backgroundImage: NetworkImage(
                    //         "https://booleanstrings.com/wp-content/uploads/2021/10/profile-picture-circle-hd.png"),
                    //   ),
                    // ),

                    // Positioned(
                    //   bottom: -10,
                    //   left: 80,
                    //   child: IconButton(
                    //     icon: const Icon(Icons.add_a_photo),
                    //     onPressed: () {},
                    //   ),
                    // ),

                    // SizedBox(
                    //   width: 120,
                    //   height: 120,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(100),
                    //     child: const Image(
                    //       image: AssetImage("assets/images/user_profile.JPG"),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   child: Container(
                    //     width: 35,
                    //     height: 35,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(100),
                    //       color: Colors.red,
                    //     ),
                    //     child: const Icon(
                    //       LineAwesomeIcons.alternate_pencil,
                    //       color: Colors.white,
                    //       size: 20,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              //username
              Text(
                '    Name: ${_userInfo['username'] ?? 'N/A'}',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold),
              ),
              //user email
              Text(
                "    Email: ${_userInfo['userEmail'] ?? "N/A"}",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              //user contact
              Text(
                "Contact: ${_userInfo['userContact'] ?? "N/A"}",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 35,
              ),

              const Divider(),
              const SizedBox(
                height: 10,
              ),
              // list of Menu
              ProfileMenuWidget(
                title: "Update Profile",
                icon: LineAwesomeIcons.user_edit,
                onPress: () {
                  Get.to(() => UpdateUserProfile());
                },
                endIcon: true,
                textColor: Colors.black,
              ),
              // Delete user menu
              ProfileMenuWidget(
                title: "Deleter User",
                icon: LineAwesomeIcons.cog,
                onPress: () {
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.topSlide,
                          desc: "Are your sure want to delete? ",
                          //actions to perform on cancle and ok buttons
                          btnCancelOnPress: () {
                            // Navigator.pop(context);
                          },
                          btnOkOnPress: () {
                            //delete function
                          })
                      .show();
                },
                endIcon: true,
                textColor: Colors.black,
              ),

              //logout buton
              ProfileMenuWidget(
                title: "Logout",
                textColor: Colors.red,
                icon: LineAwesomeIcons.alternate_sign_out,
                onPress: () {
                  //waring before loglout
                  logoutFunction(context).show();
                },
                endIcon: false,
              ),

              // if (_userInfo.containsKey('photoURL'))
              //   CircleAvatar(
              //     radius: 60,
              //  backgroundImage: CachedNetworkImageProvider(_userInfo['photoURL']),
              //   ),

              //Text('Name: ${_userInfo['username'] ?? 'N/A'}'),
            ],
          ),
        ),
      ),
    );
  }

//logout function
  AwesomeDialog logoutFunction(BuildContext context) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        desc: "Are your sure want to logout? ",
        //actions to perform on cancle and ok buttons
        btnCancelOnPress: () {
          Get.to(() => const ProfileScreen());
        },
        btnOkOnPress: () {
          //logout function
          FirebaseAuth.instance.signOut();
          Get.off(() => const LoginScreen());
          signOut();
        });
  }
}

// Function to log the user out
Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    Get.off(() => const LoginScreen());
  } catch (e) {
    print("Error signing out: $e");
    // Handle errors if sign-out fails.
  }
}

//function
Future<Map<String, dynamic>> fetchUserInfo() async {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> userInfo = {};

  if (user != null) {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .get();
    userInfo = snapshot.data() ?? {};
  }

  return userInfo;
}
