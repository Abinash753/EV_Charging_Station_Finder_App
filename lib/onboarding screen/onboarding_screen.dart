import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_authentication/login_scree.dart';

//import '../registration_login/registration_page.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //list of onboarding pages
  final List<PageViewModel> pages = [
    //first onboarding screen
    PageViewModel(
      title: "E V  P O W E R",
      body: "Make Your Journey Easy And Confortable",

      image: Padding(
        padding: const EdgeInsets.all(28),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Lottie.asset(
            "assets/animations/nepal_map.json",
            width: 350,
          ),
        ),
      ),

      // image: Column(
      //   children: [
      //     const SizedBox(
      //       height: 20,
      //     ),
      //     Center(
      //       child: Lottie.asset(
      //         "assets/nepal_map.json",
      //       ),
      //     ),
      //   ],
      // ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 25,
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        imagePadding: EdgeInsets.all(20),
        //imageAlignment: Alignment.bottomCenter,
        //pageColor: Colors.white70,
      ),
    ),
    //Second Onboarding Screen
    PageViewModel(
      title: " Let's Start Your Journey",
      body: "Here, We are always with you ",
      image: Center(
        child: Lottie.asset(
          "assets/animations/first.json",
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 18,
          color: Color.fromARGB(238, 0, 0, 0),
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          color: Color.fromARGB(238, 0, 0, 0),
          fontSize: 15,
        ),
      ),
    ),
    //last onboarding screen
    // PageViewModel(
    //   title: " Let's Start Your Journey",
    //   bodyWidget: Column(
    //     children: [
    //       MaterialButton(
    //         height: 58,
    //         minWidth: 340,
    //         shape:
    //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
    //         onPressed: () {
    //           // Navigator.push(
    //           //             context,
    //           //             MaterialPageRoute(
    //           //               builder: (context) => const RegistrationScreen(),
    //           //             ),
    //           //           );
    //         },
    //         child: Text(
    //           "Register Now",
    //           style: TextStyle(
    //             fontSize: 24,
    //             color: Colors.black,
    //           ),
    //         ),
    //         color: Color.fromARGB(255, 24, 247, 24),
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       // TextButton(
    //       //   onPressed: () {},
    //       //   child: const Text(
    //       //     "Skip for now ",
    //       //     style: TextStyle(
    //       //       fontSize: 20,
    //       //       fontWeight: FontWeight.bold,
    //       //     ),
    //       //   ),
    //       //   style: ButtonStyle(),
    //       // ),
    //     ],
    //   ),
    //   image: Center(
    //     child: Lottie.asset(
    //       "assets/animations/signup.json",
    //     ),
    //   ),
    //   decoration: const PageDecoration(
    //     titleTextStyle: TextStyle(
    //       fontSize: 18,
    //       color: Color.fromARGB(255, 4, 254, 33),
    //       fontWeight: FontWeight.bold,
    //     ),
    //     bodyTextStyle: TextStyle(
    //       color: Color.fromARGB(255, 87, 87, 87),
    //       fontSize: 15,
    //     ),
    //   ),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //     title: const Text("On Boarding Screen"),
      //     centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: IntroductionScreen(
          pages: pages,
          dotsDecorator: DotsDecorator(
            size: const Size(20, 20),
            color: const Color.fromARGB(255, 0, 0, 0),
            activeSize: const Size(45, 20),
            activeColor: const Color.fromARGB(255, 255, 255, 255),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          showDoneButton: true,
          done: Container(
            margin: const EdgeInsets.only(left: 30, bottom: 30),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  width: 7,
                ),
                color: Colors.black),
            child: const Text(
              "Done",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 255, 254, 254)),
            ),
          ),
          showSkipButton: true,
          skip: Container(
            margin: const EdgeInsets.only(right: 25, bottom: 30),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  width: 7,
                ),
                color: Colors.black),
            child: const Text(
              "Skip",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 255, 254, 254)),
            ),
          ),
          showNextButton: true,
          next: Container(
            margin: const EdgeInsets.only(left: 35, bottom: 30),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 8),
              color: Colors.black,
            ),
            child: const Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.white,
            ),
          ),
          onDone: () {
            onDOne(context);
          },
          curve: Curves.bounceOut,
          globalBackgroundColor: Colors.orange,
        ),
      ),
    );
  }
}

//call function of onDOne which nevigate to home screen
void onDOne(context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("ON_BOARDING", false);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ),
  );
}
