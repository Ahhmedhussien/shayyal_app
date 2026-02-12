import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shyal/Screens/HomeScreen.dart';
import 'package:shyal/Screens/LoginScreen.dart';
import 'package:shyal/Screens/OnboardingScreen.dart';
import 'package:shyal/Screens/OtpScreen.dart';
import 'package:shyal/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => checkFirstSeen());
  }

  Future<void> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seenOnboarding') ?? false);
    if (_seen) {
      Navigator.pushReplacementNamed(context, '/LoginScreen');
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => OtpScreen(
      //               email: "Steven@gmail.com",
      //             )));
    } else {
      await prefs.setBool('seenOnboarding', true);
      Navigator.pushReplacementNamed(context, '/OnboardingScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double imageSize = screenSize.width * 0.6;

    return Scaffold(
      backgroundColor: Color(0xff1D2623),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Color(0xFF161F1C),
              child: Image.asset(
                'assets/img/logo1.png',
                width: imageSize,
              ),
            ),
            SizedBox(height: screenSize.height * 0.03),
            Text(
              "Shayal",
              style: TextStyle(
                color: green_color,
                fontSize: screenSize.width *
                    0.05, // Approximately 5% of screen width, adjust the size accordingly
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
