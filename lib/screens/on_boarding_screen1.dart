import 'package:estate/constants/colors.dart';
import 'package:estate/screens/login_screen.dart';
import 'package:estate/screens/signup_screen.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen1 extends StatefulWidget {
  const OnBoardingScreen1({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen1> createState() => _OnBoardingScreen1State();
}

class _OnBoardingScreen1State extends State<OnBoardingScreen1> {
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            PageView(
              onPageChanged: (val) {
                setState(() {
                  selectedPage = val;
                });
                print(val);
              },
              children: [
                Image.asset(
                  "assets/home2.jpg",
                  width: fullWidth(context),
                  height: fullHeight(context),
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/home3.jpg",
                  width: fullWidth(context),
                  height: fullHeight(context),
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/home1.jpg",
                  width: fullWidth(context),
                  height: fullHeight(context),
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
              child: Column(
                children: [
                  AppName(30, false),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: selectedPage == 0 ? 13 : 10,
                            height: selectedPage == 0 ? 13 : 10,
                            decoration: BoxDecoration(
                                color: selectedPage == 0 ? white : grey,
                                shape: BoxShape.circle),
                          ),
                          HSpace(20),
                          Container(
                            width: selectedPage == 1 ? 13 : 10,
                            height: selectedPage == 1 ? 13 : 10,
                            decoration: BoxDecoration(
                                color: selectedPage == 1 ? white : grey,
                                shape: BoxShape.circle),
                          ),
                          HSpace(20),
                          Container(
                            width: selectedPage == 2 ? 13 : 10,
                            height: selectedPage == 2 ? 13 : 10,
                            decoration: BoxDecoration(
                                color: selectedPage == 2 ? white : grey,
                                shape: BoxShape.circle),
                          )
                        ],
                      ),
                      VSpace(50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SecondaryMaterialButton(() {
                            goto(context, SignUpScreen());
                          }, "Sign Up", white, 150, black),
                          PrimaryOutlineButton(() {
                            goto(context, LogInScreen());
                          }, "Sign In", 150)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
