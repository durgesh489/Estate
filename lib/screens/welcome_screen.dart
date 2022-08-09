import 'package:estate/constants/colors.dart';
import 'package:estate/screens/login_screen.dart';
import 'package:estate/screens/on_boarding_screen1.dart';
import 'package:estate/screens/signup_screen.dart';
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
              DemoScreen("WELCOME", "welcome1",
                  "Showcase your property for sale. and find the buyer easily"),
              DemoScreen("OUR REACH", "welcome2",
                  "Available in 3 major city Kathmandu ,Bhaktapur and Lalitpur"),
              DemoScreen(
                  "OTHER SERVICES", "welcome3", "Find Room and Flat to Rent")
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
                          color: selectedPage == 0 ? grey : white,
                          shape: BoxShape.circle),
                    ),
                    HSpace(20),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: selectedPage == 1 ? grey : white,
                          shape: BoxShape.circle),
                    ),
                    HSpace(20),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: selectedPage == 2 ? grey : white,
                          shape: BoxShape.circle),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {
                      gotoWithoutBack(context, OnBoardingScreen1());
                    },
                    child: nAppText("SKIP >>", 16, white))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget DemoScreen(String title, String img, String content) {
    return Container(
      width: fullWidth(context),
      height: fullHeight(context),
      color: mc,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 35, fontWeight: FontWeight.bold, color: white),
              textAlign: TextAlign.center,
            ),
            VSpace(20),
            Image.asset(
              "assets/$img.png",
              width: 300,
              height: 300,
            ),
            VSpace(20),
            Text(
              content,
              style: TextStyle(
                  fontSize: 19, fontStyle: FontStyle.italic, color: white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
