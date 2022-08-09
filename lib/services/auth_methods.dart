import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  Future getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser;
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();

    
  }
  
}