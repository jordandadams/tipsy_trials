import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tipsy_trials/views/root.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offAll(AppRoot()); // Use Get.offAll to navigate to AppRoot
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo2.png',
          height: 250,
          width: 250,
          ),
      ),
    );
  }
}