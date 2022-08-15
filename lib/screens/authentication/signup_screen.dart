import 'package:estate/constants/colors.dart';
import 'package:estate/main.dart';
import 'package:estate/screens/authentication/login_screen.dart';
import 'package:estate/screens/main/main_screen.dart';
import 'package:estate/services/database_methods.dart';
import 'package:estate/widgets/custom_textfield.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPswrdController = TextEditingController();
  TextEditingController pswrdController = TextEditingController();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  bool showCPI = false;
  Future signUpWithEmailAndPassword() async {
    setState(() {
      showCPI = true;
    });
    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: pswrdController.text);
      User? user = result.user;
      if (user != null) {
         prefs!.setString("id", user.uid);
          prefs!.setString("name", user.displayName??"unknown");
          prefs!.setString("profile", user.photoURL??"unknown");

          prefs!.setString("email", emailController.text);
          prefs!.setString("password", pswrdController.text);
          prefs!.setBool("islogin", true);
        DatabaseMethods().addUserInfoToDB(
            user.uid, {"email": emailController.text}).then((value) {
          goOff(context, MainScreen());
          showSnackbar(context, "Registration Successfully Welcome to Estate");
        });
      }
    } catch (e) {
      setState(() {
        showCPI = false;
      });
      print(e);
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
                key: signUpKey,
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
                    VSpace(10),
                    CustomTextField(
                      controller: confirmPswrdController,
                      validators: [
                        RequiredValidator(errorText: "This Field is Required"),
                        MinLengthValidator(8,
                            errorText: "Password should be atleast 8 digits")
                      ],
                      hintText: "Confirm Password",
                      isPassword: true,
                    ),
                    VSpace(40),
                    showCPI
                        ? CircularProgressIndicator()
                        : SecondaryMaterialButton(() {
                            if (signUpKey.currentState!.validate() &&
                                pswrdController.text.toString() ==
                                    confirmPswrdController.text.toString()) {
                              signUpWithEmailAndPassword();
                            } else if (pswrdController.text.toString() !=
                                confirmPswrdController.text.toString()) {
                              showSnackbar(context, "Password do not match");
                            } else {
                              showSnackbar(
                                  context, "Pleasefill all fields correctly");
                            }
                          }, "SIGN UP", btnCol, 220, white),
                    VSpace(15),
                    TextButton(
                        onPressed: () {
                          goto(context, LogInScreen());
                        },
                        child: normalText("Already Registered?", 18))
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
