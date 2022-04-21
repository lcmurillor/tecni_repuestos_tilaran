import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';

class FirebaseAuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static signIn(String email, String password, context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, 'home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        NotificationsService.showSnackbar('El usuario indicado no existe.');
      } else if (e.code == 'wrong-password') {
        NotificationsService.showSnackbar(
            'El usuario o la contraseña es incorrecta.');
      }
    }
  }
}
