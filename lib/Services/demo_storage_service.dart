import 'notifications_service.dart';

class DemoStorageService {
  static Future<void> uploadProductFile(String path, String name) async =>
      notice();
  static Future<void> uploadUserFile(String path, String name) async =>
      notice();
  static Future<void> uploadOrderFile(String path, String name) async =>
      notice();
  static void notice() => NotificationsService.showSnackbar(
    'Las cargas de archivos están deshabilitadas en este prototipo.',
  );
}
