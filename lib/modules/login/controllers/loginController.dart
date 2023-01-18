import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  TextEditingController email = TextEditingController();

  TextEditingController senha = TextEditingController();
  login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: senha.text);
    } catch (e) {
      rethrow;
    }
  }
}
