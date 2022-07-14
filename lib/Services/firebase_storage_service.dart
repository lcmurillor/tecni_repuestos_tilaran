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
  static uploadFile(String path, String name) async {
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
}
