import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserAuthentication extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  void initialAuthStateChanges() {
    auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is not signed in');
      } else {
        print('User is signed in');
      }
    });
  }

  // login
  void loginAccount(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  // register
  void registerAccount(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Password is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('Email already used');
      }
    } catch (e) {
      print(e);
    }
  }

  // signout
  void exitAccount() async {
    await FirebaseAuth.instance.signOut();
  }

  // get userID
  String getUserID() {
    String result = "null";
    if (FirebaseAuth.instance.currentUser != null) {
      result = FirebaseAuth.instance.currentUser.uid;
    }

    return result;
  }
}

UserAuthentication userAuthentication = new UserAuthentication();
