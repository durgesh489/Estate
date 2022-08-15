import 'package:estate/constants/colors.dart';
import 'package:estate/screens/authentication/login_screen.dart';
import 'package:estate/screens/main/main_screen.dart';
import 'package:estate/screens/authentication/signup_screen.dart';
import 'package:estate/widgets/custom_widgets.dart';

import 'package:flutter/material.dart';

class OnBoardingScreen1 extends StatefulWidget {
  const OnBoardingScreen1({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen1> createState() => _OnBoardingScreen1State();
}

class _OnBoardingScreen1State extends State<OnBoardingScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mc,
      body: SafeArea(
        child: Container(
          width: fullWidth(context),
          height: fullHeight(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  goOff(context, MainScreen());
                },
                child: normalText("Continue without logging in >>", 17),
              ),
              VSpace(100),
              Image.asset(
                "assets/logo.png",
                width: 250,
                height: 250,
              ),
              VSpace(50),
              SecondaryMaterialButton(() {
                goto(context, LogInScreen());
              }, "LOGIN", btnCol, 220, white),
              VSpace(20),
              PrimaryOutlineButton(() {
                goto(context, SignUpScreen());
              }, "SIGN UP", 220)
            ],
          ),
        ),
      ),
    );
  }
}
