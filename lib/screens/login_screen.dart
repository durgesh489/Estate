import 'package:estate/constants/colors.dart';
import 'package:estate/screens/change_password_screen.dart';
import 'package:estate/screens/forgot_password_screen.dart';
import 'package:estate/screens/main_screen.dart';
import 'package:estate/screens/signup_screen.dart';
import 'package:estate/services/database_methods.dart';
import 'package:estate/widgets/custom_textfield.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController pswrdController = TextEditingController();
  bool showCPI = false;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  signInWithEmailAndPassword() async {
    setState(() {
      showCPI = true;
    });
    try {
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: pswrdController.text);
      User? user = result.user;

      if (user != null) {
        try {
       goOff(context, MainScreen());
            showSnackbar(
                context, "Login Successfully Welcome to Estate");
        } catch (e) {
          setState(() {
            showCPI = false;
          });

          showSnackbar(context, e.toString());
        }
      }
    } catch (e) {
      setState(() {
        showCPI = false;
      });
      showSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mc,
      body: SafeArea(
        child: Container(
          width: fullWidth(context),
          height: fullHeight(context),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: loginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    VSpace(40),
                    Image.asset(
                      "assets/logo.png",
                      width: 200,
                      height: 200,
                    ),
                    VSpace(40),
                    CustomTextField(
                      controller: emailController,
                      validators: [
                        RequiredValidator(errorText: "This Field is Required"),
                        EmailValidator(errorText: "This is not a valid email")
                      ],
                      hintText: "Enter Email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    VSpace(10),
                    CustomTextField(
                      controller: pswrdController,
                      validators: [
                        RequiredValidator(errorText: "This Field is Required"),
                        MinLengthValidator(8,
                            errorText: "Password should be atleast 8 digits")
                      ],
                      hintText: "Enter Password",
                      isPassword: true,
                    ),

                    VSpace(60),
                    showCPI
                        ? CircularProgressIndicator()
                        : SecondaryMaterialButton(() {
                            if (loginKey.currentState!.validate()) {
                              signInWithEmailAndPassword();
                            } else {
                              showSnackbar(
                                  context, "Pleasefill all fields correctly");
                            }
                          }, "LOGIN", btnCol, 220, white),
                    VSpace(10),
                    TextButton(
                        onPressed: () {
                          goto(context, LogInScreen());
                        },
                        child: normalText("Forgot Password?", 18)),
                    // VSpace(10),
                    TextButton(
                        onPressed: () {
                          goto(context, SignUpScreen());
                        },
                        child: normalText("Register?", 18)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
