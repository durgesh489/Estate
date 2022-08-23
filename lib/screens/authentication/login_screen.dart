import 'package:estate/constants/colors.dart';
import 'package:estate/main.dart';
import 'package:estate/screens/authentication/change_password_screen.dart';
import 'package:estate/screens/authentication/forgot_password_screen.dart';
import 'package:estate/screens/main/main_screen.dart';
import 'package:estate/screens/authentication/signup_screen.dart';
import 'package:estate/services/database_methods.dart';
import 'package:estate/widgets/custom_textfield.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  GoogleSignIn googleSignIn = GoogleSignIn();
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
          prefs!.setString("id", user.uid);
          prefs!.setString("name", user.displayName??"");
          prefs!.setString("profile", user.photoURL??"");

          prefs!.setString("email", emailController.text);
          prefs!.setString("password", pswrdController.text);
          prefs!.setBool("islogin", true);
          goOff(context, MainScreen());
          showSnackbar(context, "Login Successfully Welcome to Estate");
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

  signInWithGoogle() async {
    try {
      GoogleSignInAccount? user = await googleSignIn.signIn();
      prefs!.setString("id", user!.id);
      prefs!.setString("name", user.displayName??"");
    
      prefs!.setString("email", emailController.text);
      prefs!.setString("password", pswrdController.text);
      prefs!.setBool("islogin", true);
      goOff(context, MainScreen());
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey2,
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
                      width: 150,
                      height: 150,
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
                    VSpace(20),
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

                    VSpace(30),
                    showCPI
                        ? CircularProgressIndicator()
                        : PrimaryMaterialButton(context,() {
                            if (loginKey.currentState!.validate()) {
                              signInWithEmailAndPassword();
                            } else {
                              showSnackbar(
                                  context, "Pleasefill all fields correctly");
                            }
                          }, "LOGIN"),

                    VSpace(15),
                    normalText("Or", 16),
                    VSpace(15),
                    MaterialButton(
                      minWidth: fullWidth(context),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      height: 45,
                      color: white,
                      onPressed: () {
                        signInWithGoogle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/google.png"),
                          HSpace(10),
                          Text(
                            "Sign In With Google",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    VSpace(10),
                   
                    // VSpace(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        normalText("Don't have an Account ?", 17),
                        TextButton(
                            onPressed: () {
                              goto(context, SignUpScreen());
                            },
                            child: nAppText("Sign Up", 17,green)),
                      ],
                    ),
                     TextButton(
                        onPressed: () {
                          gotoWithoutBack(context, LogInScreen());
                        },
                        child: nAppText("Forgot Password", 17,green)),
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
