import 'package:estate/constants/colors.dart';
import 'package:estate/screens/login_screen.dart';
import 'package:estate/screens/signup_screen.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';



class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: fullWidth(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VSpace(130),
                  normalText("Welcome to", 25),
                  VSpace(20),
                  boldText("Garden Place", 25),
                  VSpace(40),
                  Image.asset("assets/logo.png"),
                  VSpace(60),
                  MaterialButton(
                    minWidth: fullWidth(context),
                    height: 45,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: white,
                    elevation: 10,
                    onPressed: () {
                      gotoc(context, SignUpScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/google_logo.png",width: 20,height: 20,),
                        HSpace(5),
                        normalText("Sign Up with Google", 17),
                      ],
                    ),
                  ),
                  VSpace(20),
                  normalText("Or", 15),
                  VSpace(20),
                  InkWell(
                    onTap: () {
                      gotoc(context, SignUpScreen());
                    },
                    child: normalText("Sign Up with Email", 16),
                  ),
                  VSpace(100),
                  InkWell(
                      onTap: () {
                        goto(context, LogInScreen());
                      },
                      child: nAppText("I already have an account", 16, green))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
