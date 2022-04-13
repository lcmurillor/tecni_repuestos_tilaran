import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthProvicer extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  signIn(String email, String password, context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(userCredential);
      User? user = auth.currentUser;

      if (user != null && !user.emailVerified) {
        print('ESTE ES EL UID DE LA PERSON> ${user.uid}');
        Navigator.pushReplacementNamed(context, 'home');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Usuario no encontrado.');
      } else if (e.code == 'wrong-password') {
        print('Usuario o contraseña inválida.');
      }
    }
  }
  
}
