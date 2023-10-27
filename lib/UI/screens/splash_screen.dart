import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_app/UI/screens/home/home_screen.dart';
import 'package:movies_app/shared/components.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() =>
      SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashScreenState();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      navigateAndFinish(context, HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Image.asset('assets/images/splash.png',
        width: size.width,
        height: size.height,
        fit: BoxFit.fill,
      ),
    );
  }
}