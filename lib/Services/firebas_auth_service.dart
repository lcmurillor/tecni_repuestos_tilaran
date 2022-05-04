import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
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

  ///Permite serra la sesión de un usario registrado, además de esto navega a la página
  ///principal y con esto actualiza las opciones disponibles en el menú laterañ.
  static signOut(context) async {
    try {
      await auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      NotificationsService.showSnackbar(
          'Ha ocurrodo un error al cerrar la sesión: $e');
    }
  }

  ///Permite crear nuevos usuarios, primeramente los registra con los sistemas de
  ///autentificacion de firebase y luego guarda datos adicionales en la base de datos
  ///asociados con el UID. al final guarda el usario en la memoria y abre el menu principal.
  static logIn(
      String email, String password, UserModel userModel, context) async {
    try {
      ///Proceso de creación de un nuevo usario en el apartado de "Autentificación" de Firebase.
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userModel.id = userCredential.user!.uid;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      FirebaseCloudService.setUser(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        NotificationsService.showSnackbar(
            'La contraseña indica no cumple con los requerimintos mínimos.');
      } else if (e.code == 'email-already-in-use') {
        NotificationsService.showSnackbar(
            'Ya existe una cuenta registrada con este correo.');
      }
    }
  }
}
