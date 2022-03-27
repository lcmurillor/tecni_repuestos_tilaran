import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier {
  void getUsers() async {
    CollectionReference colletionReference =
        FirebaseFirestore.instance.collection("pruebausuarios");

    QuerySnapshot users = await colletionReference.get();

    if (users.docs.length != 0) {
      for (var doc in users.docs) {
        print(doc.data());
      }
    }
  }

//haciendo prueba de agregar
  void addPruebaUsuarios() {
    FirebaseFirestore.instance
        .collection("pruebausuarios")
        .add({'nombre': 'Pedro'});
  }

  void updateUsuarios() {
    FirebaseFirestore.instance
        .collection("pruebausuarios")
        .doc('xfOZ5bpOA51XBG6CbO5Q')
        .update({'nombre': 'Francisco'});
  }

  void deletePruebaUsuarios() {
    FirebaseFirestore.instance
        .collection("pruebausuarios")
        .doc('VimDJ1bLgs1VGQfBr8ms') // en el doc se manda el id a eliminar
        .delete();
  }

  /* PROBANDO AUTENTIFICACIÓN */
  signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "usuario@correo.com", password: "111111");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
