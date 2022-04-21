import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/screens/screens.dart';

///Ésta clase corresponde a la conección que se tiene con la base de datos Firebase
///relacionada con el apartado de credenciales y autetificación de usuario.
class FirebaseAuthService {
  /// Valor estatatico para hacer llamado a éste en diferentes partes del programa
  /// retorna los valores del usuario y el estado de la instancia registrada.
  static final FirebaseAuth auth = FirebaseAuth.instance;

  ///Médoto para inicicar sesión mediante el correo y la contraseña,
  ///Valida si el usario existe o si los datos incresados corresponden a un usuario registrado
  ///sinó es así, retorna un mensaje en pantalla.
  ///Guarda los datos en un objeto de tipo User.
  static signIn(String email, String password, context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        NotificationsService.showSnackbar('El usuario indicado no existe.');
      } else if (e.code == 'wrong-password') {
        NotificationsService.showSnackbar(
            'El usuario o la contraseña es incorrecta.');
      }
    }
  }

  static signOut(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      NotificationsService.showSnackbar(
          'Ha ocurrodo un error al cerrar la sesión: $e');
    }
  }
}
