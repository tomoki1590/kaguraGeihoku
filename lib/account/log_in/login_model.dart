import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  final mailAdress = TextEditingController();
  final passWord = TextEditingController();
  String? mail;
  String? pass;

  Future emailSignIn() async {
    mail = mailAdress.text;
    pass = passWord.text;

    if (mail != null && pass != null) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail!, password: pass!);
      notifyListeners();
    }
  }
}
