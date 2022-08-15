import 'package:estate/constants/colors.dart';
import 'package:estate/main.dart';
import 'package:estate/screens/authentication/login_screen.dart';
import 'package:estate/screens/profile/personal_information_screen.dart';
import 'package:estate/services/auth_methods.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mc,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        "assets/person.png",
                        color: white,
                      ),
                      HSpace(20),
                      prefs!.getBool("islogin") == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    prefs!.getString("email") ??
                                        "unknown@gmail.com",
                                    18),
                                VSpace(5),
                                boldText(
                                    prefs!.getString("email").toString().replaceAll("@gmail.com", ""), 15)
                              ],
                            )
                          : Column(
                              children: [
                                boldText("Welcome", 30),
                                Row(
                                  children: [
                                    MaterialButton(
                                      minWidth: 100,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      height: 35,
                                      color: btnCol,
                                      onPressed: () {},
                                      child: bAppText("Login", 18, white),
                                    ),
                                    HSpace(15),
                                    SizedBox(
                                      width: 100,
                                      height: 35,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: white),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                        ),
                                        onPressed: () {},
                                        child: bAppText("Register", 18, white),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: white,
                ),
                VSpace(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: boldText("Account Setting", 25),
                ),
                VSpace(15),
                DrawerItems(Icons.person_rounded, "Person Information", () {
                  goto(context, PersonalInformationScreen());
                }),
                DrawerItems(
                    Icons.notifications_outlined, "Notifications", () {}),
                DrawerItems(
                    Icons.lock_open_outlined, "Privacy and Security", () {}),
                DrawerItems(Icons.call, "Contact US", () {}),
                DrawerItems(Icons.info_outline, "About Us", () {}),
                VSpace(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: boldText("Help Support", 25),
                ),
                VSpace(15),
                DrawerItems(Icons.help_outline, "Get Help", () {}),
                DrawerItems(Icons.feedback_outlined, "Give Us Feedback", () {}),
                VSpace(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: boldText("Legal", 25),
                ),
                VSpace(15),
                DrawerItems(Icons.assignment, "Terms and Condition", () {}),
                DrawerItems(Icons.policy_outlined, "Privacy Policy", () {}),
                DrawerItems(Icons.logout, "Log Out", () {
                  AuthMethods().signOut().then((value) {
                    prefs!.setBool("islogin", false);
                    goOff(context, LogInScreen());
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
