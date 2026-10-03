// Original interactive flow preserved in docs/admin_users_orders_screen-interactive-legacy.dart.txt.
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'demo_admin_screen.dart';

class AdminUsersOrdersScreens extends StatelessWidget {
  const AdminUsersOrdersScreens({super.key, this.user});
  final User? user;
  @override
  Widget build(BuildContext context) => DemoOrdersPage(user: user);
}
