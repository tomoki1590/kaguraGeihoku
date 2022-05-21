import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kagura_geihoku/domain/kagura.dart';

class SignUpModel extends ChangeNotifier {
  List<Account>? myAccount;

  final mailAdress = TextEditingController();
  final passWord = TextEditingController();
  final accountName = TextEditingController();

  String? mail;
  String? pass;
  String? myName;
  String? homeArea;
  String? likeTraditional;

  void setMail(String mail) {
    this.mail = mail;
    notifyListeners();
  }

  void setPass(String pass) {
    this.pass = pass;
    notifyListeners();
  }

  void setName(String myName) {
    this.myName = myName;
    notifyListeners();
  }

  Future SingnUp() async {
    mail = mailAdress.text;
    pass = passWord.text;
    myName = accountName.text;

    if (mail != null && pass != null && myName != null) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail!, password: pass!);
      notifyListeners();
    }
  }

  Future addAccount() async {
    final doc = FirebaseFirestore.instance.collection('myAccount').doc();
    await doc.set({
      'myName': myName,
      'homeArea': homeArea,
      'likeTraditional': likeTraditional,
    });
  }

  Future myAccountFetch(Account myAccount) async {
    return await FirebaseFirestore.instance
        .collection('myAccount')
        .doc(myAccount.id)
        .get();
  }
}
