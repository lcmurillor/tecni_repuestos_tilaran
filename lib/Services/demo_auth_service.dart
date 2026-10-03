import 'package:flutter/material.dart';
import 'notifications_service.dart';

class DemoIdentity {
  const DemoIdentity();
  String get uid => 'demo-user';
  String get email => 'demo@example.com';
  bool get isAnonymous => false;
}

class DemoSession {
  DemoIdentity? get currentUser => const DemoIdentity();
}

/// A fixed visitor identity, not authentication. Credentials are never stored.
class DemoAuthService {
  static final auth = DemoSession();
  static void notice() => NotificationsService.showSnackbar(
    'Prototipo: no se crean cuentas ni se envían correos.',
  );
  static Future<void> signIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    notice();
  }

  static Future<void> signOut(BuildContext context) async {
    notice();
  }

  static Future<void> logIn(
    String email,
    String password,
    dynamic user,
    BuildContext context,
  ) async {
    notice();
  }

  static Future<bool> requestPassword(
    String email,
    BuildContext context,
  ) async {
    notice();
    return true;
  }

  static Future<void> updatePassword(
    String current,
    String next,
    BuildContext context,
  ) async {
    notice();
  }
}
