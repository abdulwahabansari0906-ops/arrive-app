import 'dart:async';
import 'package:arrive_app/sessions/session_manager.dart';
import 'package:arrive_app/view_screens/Bottemnavigation_screen.dart';
import 'package:arrive_app/onboarding_screens/onboarding_screen1.dart';
import 'package:arrive_app/Authenticator_screens/Loginbottemsheet.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final mqsize = MediaQuery.of(context).size;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      final bool isValid = await SessionManager.isSessionValid();

      if (!mounted) return;

      if (isValid) {
        // Session valid — seedha home screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainBottomNavigation()),
              (Route<dynamic> route) => false,
        );
      } else {
        // No session / expired — onboarding phir login
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen1()),
              (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff122029),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 2),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Image.asset(
                "assets/images/LOGO.png",
                height: mqsize.height * 0.15,
                width: mqsize.width * 1,
              ),
            );
          },
        ),
      ),
    );
  }
}