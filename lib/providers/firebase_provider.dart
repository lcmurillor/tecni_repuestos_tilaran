// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';

class FirebaseProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  ///Método cosntructor del firebaseprovider
  FirebaseProvider() {
    print('Estoy en el metodo constructor');
    getHomeProducts();
  }

  Stream<List<Product>> getHomeProducts() {
    final ref = db.collection('accesorios');
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Product.fromFirebase(doc)).toList());
  }

  void getUsers() async {
    CollectionReference colletionReference =
        FirebaseFirestore.instance.collection("accesorios");

    QuerySnapshot users = await colletionReference.get();
    if (users.docs.isNotEmpty) {
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
      // ignore: unused_local_variable
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
