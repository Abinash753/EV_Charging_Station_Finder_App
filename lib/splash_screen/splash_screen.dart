//import '../home_screen.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import '../onboarding screen/onboarding_screen.dart';
import '../user_authentication/login_scree.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/animations/splash.json", controller: _controller,
              onLoaded: (compass) {
            _controller
              ..duration = compass.duration
              ..forward().then((value) =>
                  //Navigate to Home screen after splash screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            show ? OnBoardingScreen() : const LoginScreen())),
                  ));
          }),
          Center(
            child: AnimatedTextKit(animatedTexts: [
              TypewriterAnimatedText("E V    P O W E R",
                  textStyle: const TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 233, 22, 7),
                  ),
                  speed: const Duration(milliseconds: 50)),
            ]),
          ),
        ],
      ),
    );
  }
}
