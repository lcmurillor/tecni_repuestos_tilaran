import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:tecni_repuestos/services/services.dart';

///Permite establecer la conexión entre la aplicación y el apartado de almacenamiendo
///de la base de datos. Este apartado es usado exclusivamente para el almacenamiento de iamgenes,
///principalmente de productos.
class FirebaseStorageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  ///Permite cargar una nueva imagen a la base de datos, esta es asociada a su productos de dos formas.
  ///Primeramente se guarda con el nombre de identificación alfanumerico del articulo que corresponde y
  ///al articulo se le asigna la url con la cual puede acceder a la imagen. además permite la actualización
  ///simplemente sobresescribe la imagen.
  static uploadProductFile(String path, String name) async {
    File file = File(path);
    try {
      await _storage.ref('products/$name').putFile(file);
    } catch (e) {
      NotificationsService.showErrorSnackbar(
          "Ha ocurrido un error a la hora se subir la nueva imagen. Por favor, inmtentelo de nuevo.");
    }
    try {
      String url = await _storage.ref('products/$name').getDownloadURL();
      FirebaseRealtimeService.setProducImg(productId: name, url: url);
    } catch (e) {
      NotificationsService.showErrorSnackbar(
          "Ha ocurrido un error a la hora de cargar la nueva imagen. Por favor, inmtentelo de nuevo.");
    }
  }

  ///Permite cargar una nueva imagen a la base de datos, esta es asociada a su usuario de dos formas.
  ///Primeramente se guarda con el nombre de identificación alfanumerico del usuario que corresponde y
  ///al usuario se le asigna la url con la cual puede acceder a la imagen. además permite la actualización
  ///simplemente sobresescribe la imagen.
  static uploadUserFile(String path, String name) async {
    File file = File(path);
    try {
      await _storage.ref('users/$name').putFile(file);
    } catch (e) {
      NotificationsService.showErrorSnackbar(
          "Ha ocurrido un error a la hora se subir la nueva imagen. Por favor, inmtentelo de nuevo.");
    }
    try {
      String url = await _storage.ref('users/$name').getDownloadURL();
      FirebaseRealtimeService.setUserImg(userId: name, url: url);
    } catch (e) {
      NotificationsService.showErrorSnackbar(
          "Ha ocurrido un error a la hora de cargar la nueva imagen. Por favor, intentelo de nuevo.");
    }
  }

  static Future<void> uploadOrderFile(String path, String name) async {
    File file = File(path);
    try {
      await _storage.ref('orders/$name').putFile(file);
    } catch (e) {
      NotificationsService.showErrorSnackbar(
          "Ha ocurrido un error a la hora se subir la nueva imagen. Por favor, inmtentelo de nuevo.");
    }
    try {
      String url = await _storage.ref('orders/$name').getDownloadURL();
      //
      FirebaseRealtimeService.setOrderImg(orderId: name, url: url);
    } catch (e) {
      NotificationsService.showErrorSnackbar(
          "Ha ocurrido un error a la hora de cargar la nueva imagen. Por favor, inmtentelo de nuevo.");
    }
  }
}
