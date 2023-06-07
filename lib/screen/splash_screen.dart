// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () async {
      if (await loginFinished()) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (await onBoardingFinished()) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
  }

  Future<bool> onBoardingFinished() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool("Finished onBoarding") ?? false;
  }

  Future<bool> loginFinished() async {
    SharedPreferences sharedPrefLogin = await SharedPreferences.getInstance();
    return sharedPrefLogin.getBool("Finished login") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 160,
              height: 160,
              child: Image.asset('assets/images/LogoDapurBundaHijauKuning.png'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
