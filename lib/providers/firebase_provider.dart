// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';

class FirebaseProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  ///Método cosntructor. Éste métod es el primer metodo llamdo al construir la aplicación,
  ///si fuera necesario hacer un llamdo a auna instancia, clase o función de firebase antes de
  ///la cosntrucción de los widgets, se puede hacer acá.
  FirebaseProvider() {
    null;
  }

  ///Este método obtiene una lista de objetos de tipo producto que obtiene desde
  ///la base de datos mediante la libreria de firebase
  Stream<List<Product>> getHomeProducts() {
    final ref = db.collection('accesorios');
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Product.fromFirebase(doc)).toList());
  }

  ///Éste método obtiene una lista de objetos de tipo categoria los cuales correspondan
  ///a la categoria de accesorios.
  Stream<List<Category>> getAccessoriesCategory() {
    final ref = db
        .collection('categories')
        .where('type', isEqualTo: 'accesorios')
        .orderBy('category_label');
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Category.fromFirebase(doc)).toList());
  }

  ///Éste método obtiene una lista de objetos de tipo categoria los cuales correspondan
  ///a la categoria de repuestos.
  Stream<List<Category>> getSparesCategory() {
    final ref = db
        .collection('categories')
        .where('type', isEqualTo: 'repuesto')
        .orderBy('category_label');
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Category.fromFirebase(doc)).toList());
  }

  ///Este método obtiene una lista de objetos de tipo producto que obtiene desde
  ///la base de datos mediante la libreria de firebase
  Stream<List<Product>> getfilteredProducts(String type, String category) {
    final ref = db.collection(type).where('category', isEqualTo: category);
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
  signInWithEmailAndPassword(String email, String password) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Usuario no encontrado para este email.');
      } else if (e.code == 'wrong-password') {
        print('Contraseña no coincide con el email.');
      }
    }
  }
}
