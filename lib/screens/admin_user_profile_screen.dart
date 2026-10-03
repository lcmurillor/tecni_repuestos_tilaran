// Original interactive flow preserved in docs/admin_user_profile_screen-interactive-legacy.dart.txt.
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'demo_admin_screen.dart';

class AdminUserProfileScreen extends StatelessWidget {
  const AdminUserProfileScreen({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) => DemoUserPage(user: user);
}
