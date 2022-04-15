import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {

  Future<String> currentUser();
  Future<String> login(String email, String password);
  Future<String> createUser(String email, String password);
  Future<String> signOut();
}
class Auth with ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "rahulkujur31@gmail.com",
          password: "r@K5566221"
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }


  Future<void> createUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: "rahulkujur31@gmail.com", password: "r@K5566221"
      );
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }


  Future<void> getCurrentUser() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print(currentUser.uid);
    }
  }
  Future<void> signOut() async {
    return auth.signOut();
  }

}