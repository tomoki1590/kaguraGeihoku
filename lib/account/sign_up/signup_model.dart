import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kagura_geihoku/domain/kagura.dart';

class SignUpModel extends ChangeNotifier {
  List<Account>? myAccount;

  final mailAdress = TextEditingController();
  final passWord = TextEditingController();
  String? mail;
  String? pass;
  String? myName;
  String? homeArea;
  String? likeTraditional;
  String? uid;
  Account? account;

  void setMail(String mail) {
    this.mail = mail;
    notifyListeners();
  }

  void setPass(String pass) {
    this.pass = pass;
    notifyListeners();
  }

  Future SignUp() async {
    mail = mailAdress.text;
    pass = passWord.text;

    if (mail != null && pass != null) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail!, password: pass!)
          .then((currentUser) => FirebaseFirestore.instance
                  .collection("myAccount")
                  .doc(currentUser.user!.uid)
                  .set({
                "uid": currentUser.user!.uid,
                "email": mailAdress.text,
                'homeArea': homeArea,
                'myName': myName,
                'likeTraditional': likeTraditional,
              }));
    }
  }

  void myAccountFetch() async {
    print('iru?');
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('myAccount')
        .doc('J4LFUyPIkgbZkA0M8HJNDPJl7JP2')
        .get();
    myName = snapshot.get('myName');
    uid = snapshot.get('uid');
    print('Nullだよ');
  }
}
