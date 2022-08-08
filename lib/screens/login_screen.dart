import 'package:estate/constants/colors.dart';
import 'package:estate/screens/change_password_screen.dart';
import 'package:estate/screens/forgot_password_screen.dart';
import 'package:estate/screens/main_screen.dart';
import 'package:estate/screens/signup_screen.dart';
import 'package:estate/widgets/custom_textfield.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pswrdController = TextEditingController();
  bool isPhone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppName(25, false),
                  VSpace(30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          boldText(
                              isPhone
                                  ? "Enter Phone Number"
                                  : "Enter Email Address",
                              14),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  isPhone = !isPhone;
                                });
                              },
                              child: nAppText(
                                  isPhone
                                      ? "Sign Up With Email"
                                      : "Sign Up With Phone Number",
                                  13,
                                  mc))
                        ],
                      ),
                      VSpace(10),
                      CustomTextField(
                        controller: emailController,
                        validators: [],
                        hintText: isPhone
                            ? "Enter Phone Number"
                            : "Enter Email Address",
                      ),
                    ],
                  ),
                  VSpace(30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText("Enter Password", 14),
                      VSpace(10),
                      CustomTextField(
                        controller: pswrdController,
                        validators: [],
                        hintText: "Enter Password",
                        isPassword: true,
                      ),
                    ],
                  ),
                  VSpace(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          goto(context, ForgotPasswordScreen());
                        },
                        child: normalText("Forgot Password?", 15),
                      ),
                      InkWell(
                        onTap: () {
                          goto(context, ChangePasswordScreen());
                        },
                        child: normalText("Change Password", 15),
                      ),
                    ],
                  ),
                  VSpace(15),
                  PrimaryMaterialButton(context, () {
                    goto(context, MainScreen());
                  }, "Sign In"),
                  VSpace(20),
                  InkWell(
                    onTap: () {
                      goto(context, SignUpScreen());
                    },
                    child: nAppText("You have not acoount, Sign Up", 13, grey),
                  ),
                  VSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      HSpace(20),
                      nAppText("Or", 16, grey),
                      HSpace(20),
                      Container(
                        width: 80,
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  VSpace(10),
                  MaterialButton(
                    elevation: 10,
                    minWidth: fullWidth(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    height: 45,
                    color: white,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/google.png"),
                        HSpace(10),
                        Text(
                          "Sign Up With Google",
                          style: TextStyle(color: black, fontSize: 15),
                        ),
                      ],
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

  Widget RoundIcon(String img) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 12,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(1200)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/$img.png"),
        ),
      ),
    );
  }
}
