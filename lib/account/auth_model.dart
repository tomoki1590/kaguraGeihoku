import 'package:firebase_auth/firebase_auth.dart';

import 'account.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentUser;
  static Account? myAccount;
  static Future<dynamic> signUp(
      {required String email,
      required String pass,
      required String name}) async {
    try {
      UserCredential newAccount = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass);
      print(' 登録完了 ');
      return newAccount;
    } on FirebaseAuthException catch (e) {
      print('$e');
      return false;
    }
  }

  static Future<dynamic> emailSignIn(
      {required String email, required String pass}) async {
    try {
      final UserCredential results = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);
      currentUser = results.user;
      print('ログイン完了');
      return results;
    } on FirebaseAuthException catch (e) {
      print('auth lost,$e');
      return false;
    }
  }
}
