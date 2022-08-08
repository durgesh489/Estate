import 'dart:async';

import 'package:estate/screens/on_boarding_screen1.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      gotoWithoutBack(context, OnBoardingScreen1());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: AppName(35, false)),
      ),
    );
  }
}
