import 'package:estate/screens/main/main_screen.dart';
import 'package:estate/screens/others/welcome_screen.dart';
import 'package:estate/services/auth_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

SharedPreferences? prefs;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // backgroundColor:mc,
        primaryColor: Colors.blue[900],
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: AuthMethods().getCurrentUser(),
          builder: (context, snapshot) {
            return snapshot.hasData ? MainScreen() : WelcomeScreen();
          }),
    );
  }
}
