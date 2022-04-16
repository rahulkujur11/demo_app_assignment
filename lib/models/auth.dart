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


  Future<User> login(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: "rahulkujur31@gmail.com", password: "r@Kk5566221");
    User user = userCredential.user!;
    return user;
  }


  Future<User> createUser(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "rahulkujur31@gmail.com", password: "r@K5566221");
    User user = userCredential.user!;
    return user;
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