import 'dart:io';
import 'dart:ui';

import 'package:estate/constants/colors.dart';
import 'package:estate/main.dart';
import 'package:estate/screens/authentication/login_screen.dart';
import 'package:estate/screens/authentication/signup_screen.dart';
import 'package:estate/screens/profile/personal_information_screen.dart';
import 'package:estate/services/auth_methods.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey2,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            overflow: Overflow.visible,
                            children: [
                              prefs!.getString("profile") != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        File(prefs!.getString("profile")!),
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      "assets/person.png",
                                      width: 80,
                                      height: 80,
                                    ),
                              Positioned(
                                bottom: -10,
                                right: -10,
                                child: IconButton(
                                  onPressed: () {
                                    takeImage();
                                  },
                                  icon: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: green),
                                    child: Center(
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          HSpace(20),
                          prefs!.getBool("islogin") == true
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    boldText(
                                        prefs!
                                            .getString("email")
                                            .toString()
                                            .replaceAll("@gmail.com", ""),
                                        18),
                                    VSpace(5),
                                    Text(
                                      prefs!.getString("email") ??
                                          "unknown@gmail.com",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
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
                                          color: green,
                                          onPressed: () {
                                            goOff(context, LogInScreen());
                                          },
                                          child: bAppText("Login", 18, white),
                                        ),
                                        HSpace(15),
                                        SizedBox(
                                          width: 100,
                                          height: 35,
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(color: black),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                            onPressed: () {
                                              goOff(context, SignUpScreen());
                                            },
                                            child:
                                                bAppText("Register", 18, black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ),
                  VSpace(10),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boldText("Account Setting", 20),
                          VSpace(10),
                          DrawerItems(
                              Icons.person_rounded, "Person Information", () {
                            goto(context, PersonalInformationScreen());
                          }),
                          DrawerItems(Icons.notifications_outlined,
                              "Notifications", () {}),
                          DrawerItems(Icons.lock_open_outlined,
                              "Privacy and Security", () {}),
                          DrawerItems(Icons.call, "Contact US", () {}),
                          DrawerItems(Icons.info_outline, "About Us", () {}),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boldText("Help Support", 20),
                          VSpace(10),
                          DrawerItems(Icons.help_outline, "Get Help", () {}),
                          DrawerItems(Icons.feedback_outlined,
                              "Give Us Feedback", () {}),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boldText("Legal", 20),
                          VSpace(10),
                          DrawerItems(
                              Icons.assignment, "Terms and Condition", () {}),
                          DrawerItems(
                              Icons.policy_outlined, "Privacy Policy", () {}),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? image;
  bool isImageSelected = false;
  final ImagePicker picker = new ImagePicker();
  var imageUrl;

  Future getImageFromGallery() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = pickedFile.path;
        prefs!.setString("profile", image!);

        isImageSelected = true;
      } else {
        print("no image selected");
      }
    });
  }

  Future captureImageFromCamera() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = pickedFile.path;
        prefs!.setString("profile", image!);
        isImageSelected = true;
      } else {
        print("no image selected");
      }
    });
  }

  Future imageUpload() async {}

  takeImage() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Select any option",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
                child: Text(
                  "Select Image from Gallery",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () async {
                  getImageFromGallery();
                }),
            SimpleDialogOption(
                child: Text(
                  "Capture Image from Camera",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () async {
                  captureImageFromCamera();
                }),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                goBack(context);
              },
            ),
          ],
        );
      },
    );
  }
}
