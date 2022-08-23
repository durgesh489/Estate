import 'package:estate/constants/colors.dart';
import 'package:estate/screens/authentication/login_screen.dart';
import 'package:estate/screens/main/main_screen.dart';
import 'package:estate/screens/others/on_boarding_screen1.dart';
import 'package:estate/screens/authentication/signup_screen.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _OnBoardingScreen1State();
}

class _OnBoardingScreen1State extends State<WelcomeScreen> {
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView(
            onPageChanged: (val) {
              setState(() {
                selectedPage = val;
              });
              print(val);
            },
            children: [
              DemoScreen(
                  "Find Your Dream House",
                  "3",
                  "Still searching for you dream house? Then you are at the right app.Search and Find your dream house on tip of your finger",
                  "NEXT"),
              DemoScreen(
                  "Search For Affordable Office Space",
                  "1",
                  "Unable to find the perfect office space?Then you are at the right app.Search and Find the perfect space for your office",
                  "NEXT"),
              DemoScreen(
                  "Find The Land, build your House",
                  "2",
                  "Seeking for the perfect Land to build house ?  search and find the perfect Land to built your house",
                  "SKIP")
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: selectedPage == 0 ? green : white,
                          shape: BoxShape.circle),
                    ),
                    HSpace(20),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: selectedPage == 1 ? green : white,
                          shape: BoxShape.circle),
                    ),
                    HSpace(20),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: selectedPage == 2 ? green : white,
                          shape: BoxShape.circle),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {
                      gotoWithoutBack(context, LogInScreen());
                    },
                    child: nAppText("SKIP", 16, black))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget DemoScreen(String title, String img, String content, String btnText) {
    return Container(
      width: fullWidth(context),
      height: fullHeight(context),
      color: grey2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/$img.jpeg",
              width: 300,
              height: 300,
            ),
            VSpace(20),
            Text(
              title,
              style: TextStyle(
                fontSize: 35,
              ),
              textAlign: TextAlign.center,
            ),
            VSpace(20),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            VSpace(30),
            SecondaryMaterialButton(() {
              goOff(context, MainScreen());
            }, "Get Started", 200),
          ],
        ),
      ),
    );
  }
}
