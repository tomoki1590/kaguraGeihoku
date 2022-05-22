import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kagura_geihoku/domain/kagura.dart';

class SignUpModel extends ChangeNotifier {
  List<Account>? myAccount;
  TextEditingController nameController = TextEditingController();
  TextEditingController homeAreaController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  TextEditingController likeController = TextEditingController();

  final mailAdress = TextEditingController();
  final passWord = TextEditingController();
  String? mail;
  String? pass;
  String? myName;
  String? homeArea;
  String? likeTraditional;
  String? uid;
  Account? account;

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
                'homeArea': homeAreaController.text,
                'myName': nameController.text,
                'likeTraditional': likeController.text,
                'createdTime': Timestamp.now(),
                'imagePath': imageFile!.path
              }));
    }
  }

  File? image;
  File? imageFile;
  ImagePicker picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
    return pickedFile;
  }

  void myAccountFetch() async {
    print('iru?');
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('myAccount')
        .doc('AYUl8z34mBQ8bbm6T52qbp70sm82')
        .get();
    myName = snapshot.get('myName');
    uid = snapshot.get('uid');
    print('Nullだよ');
  }
}
