import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/screens/screens.dart';

///Ésta clase corresponde a la conección que se tiene con la base de datos Firebase
///relacionada con el apartado de credenciales y autetificación de usuario.
class FirebaseAuthService {
  /// Valor estático para hacer llamado a éste en diferentes partes del programa
  /// retorna los valores del usuario y el estado de la instancia registrada.
  static final FirebaseAuth auth = FirebaseAuth.instance;

  ///Médoto para iniciar sesión mediante el correo y la contraseña,
  ///Valida si el usuario existe o si los datos ingresados corresponden a un usuario registrado
  ///sinó es así, retorna un mensaje en pantalla.
  ///Guarda los datos en un objeto de tipo User.
  static signIn(String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        NotificationsService.showErrorSnackbar(
            'El usuario indicado no existe.');
      } else if (e.code == 'wrong-password') {
        NotificationsService.showErrorSnackbar(
            'El usuario o la contraseña es incorrecta.');
      }
    }
  }

  ///Permite cerrar la sesión de un usuario registrado, además de esto navega a la página
  ///principal y con esto actualiza las opciones disponibles en el menú lateral.
  static signOut(BuildContext context) async {
    try {
      await auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      NotificationsService.showErrorSnackbar(
          'Ha ocurrodo un error al cerrar la sesión: $e');
    }
  }

  ///Permite crear un nuevos usuarios. Primeramente los registra con los sistemas de
  ///autentificación de firebase y luego guarda datos adicionales a este en la base de datos
  ///asociados con el UID. Al final guarda el usuario en la memoria y muestra la pantalla principal.
  static logIn(String email, String password, UserModel userModel,
      BuildContext context) async {
    try {
      ///Proceso de creación de un nuevo usuario en el apartado de "Autentificación" de Firebase.
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      ///Asigna el UID al objeto de tipo usuario y manda este objeto a la base de datos.
      userModel.id = userCredential.user!.uid;
      FirebaseRealtimeService.setUser(user: userModel);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        NotificationsService.showErrorSnackbar(
            'La contraseña indica no cumple con los requerimientos mínimos.');
      } else if (e.code == 'email-already-in-use') {
        NotificationsService.showErrorSnackbar(
            'Ya existe una cuenta registrada con este correo.');
      }
    }
  }

  ///Recive el correo de un usuario registrado en la aplicación y envía un correo a este
  ///en el cual puede cambiar su contraseña.
  static requestPassword(String email, BuildContext context) async {
    await auth.sendPasswordResetEmail(email: email);
    Navigator.pushReplacementNamed(context, 'login');
  }

  ///Revice la contraseña del usuario registrado actualmente y la contraseña que ele usuario
  ///desea definir como nueva contraseña, si la contraseña anterir es valida, realiza el cambio de las credenciales
  ///del usuario.
  static updatePassword(
      String currentPassword, String newPassword, BuildContext context) async {
    try {
      //Evalua si la contraseña actual es la contraseña del usuario registado
      await auth
          .signInWithEmailAndPassword(
              email: auth.currentUser!.email!, password: currentPassword)
          .then((currentUser) {
        ///Si se cumple con las credenciales del usuario, se utiliza los métodos de
        ///firebase para actualizar la contraseña.
        currentUser.user!.updatePassword(newPassword).then((_) {
          NotificationsService.showSnackbar(
              'Su contraseña fue cambiada exitosamente.');
          Navigator.pop(context);
        }).catchError((error) {
          NotificationsService.showErrorSnackbar(
              'Su contraseña no pudo ser cambiada porque no cumple los requisitos mínimos.');
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        NotificationsService.showErrorSnackbar(
            'La contraseña actual no coincide.');
      }
    }
  }
}
