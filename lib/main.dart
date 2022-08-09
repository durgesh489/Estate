import 'package:estate/screens/main_screen.dart';
import 'package:estate/screens/welcome_screen.dart';
import 'package:estate/services/auth_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // backgroundColor:mc,
        primarySwatch: Colors.grey,
      ),
       home: FutureBuilder(
          future: AuthMethods().getCurrentUser(),
          builder: (context, snapshot) {
            return snapshot.hasData? MainScreen()
                : WelcomeScreen();
          }),
    );
  }
}
