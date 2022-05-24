import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kagura_geihoku/account/auth_model.dart';

import '../domain/kagura.dart';

class UserModel extends ChangeNotifier {
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
}

class UserFireStore {
  static final firestoredata = FirebaseFirestore.instance;
  static final CollectionReference userdata =
      firestoredata.collection('userdata');

  static Future<dynamic> setUser(Account newAccount) async {
    try {
      await userdata.doc(newAccount.uid).set({});
      print('user success Account');
      return true;
    } on FirebaseException catch (e) {
      print(' error:$e');
      return false;
    }
  }

  Future<dynamic> getUser(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await userdata.doc(uid).get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      Account myAccount = Account(
          uid: uid,
          myName: data['myName'],
          homeArea: data['homeArea'],
          likeTraditional: data['likeTraditional']);
      Authentication.myAccount = myAccount;
      print('User Success');
      return true;
    } on FirebaseException catch (e) {
      print('User Eroor$e');
      return false;
    }
  }
}
