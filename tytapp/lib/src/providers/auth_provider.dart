// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  FirebaseAuth? _firebaseAuth;

  AuthProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  User? getUser() {
    return _firebaseAuth!.currentUser;
  }

  bool? isSignedIn() {
    final currentUser = _firebaseAuth?.currentUser;
    if (currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  void checkIfUserIsLogged(BuildContext context, String? typeUser) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //El usuario esta loggedo
      if (user != null && typeUser != null) {
        if (typeUser == "client") {
          print("el usuario esta loggeado");
          Navigator.pushNamedAndRemoveUntil(
              context, "ClientMapPage", ((route) => false));
        } else if (typeUser == "driver") {
          print("el usuario esta loggeado");
          Navigator.pushNamedAndRemoveUntil(
              context, "DriverMapPage", ((route) => false));
        }
      } else {
        print("el usuario no esta loggeado");
      }
    });
  }

  Future<bool> login(String email, String password) async {
    var errorMessage;

    try {
      await _firebaseAuth?.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      errorMessage = error.toString();
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

  Future<bool> register(String email, String password) async {
    var errorMessage;

    try {
      await _firebaseAuth?.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      errorMessage = error.toString();
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

// desarrollo
  Future<Future<List<void>>> signOut() async {
    return Future.wait([_firebaseAuth!.signOut()]);
  }
}
