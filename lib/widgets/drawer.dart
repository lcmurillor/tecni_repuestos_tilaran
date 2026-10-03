import 'package:tecni_repuestos/screens/demo_admin_screen.dart';
import 'package:tecni_repuestos/screens/demo_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/shared/preferences.dart';
import 'package:tecni_repuestos/screens/screens.dart';
import 'package:tecni_repuestos/screens/demo_access_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    void open(Widget screen) {
      final navigator = Navigator.of(context);
      navigator.pop();
      navigator.push(MaterialPageRoute(builder: (_) => screen));
    }

    Widget link(String label, IconData icon, Widget screen) => ListTile(
      leading: Icon(icon, color: scheme.primary),
      title: Text(label),
      trailing: Icon(
        Icons.chevron_right,
        color: scheme.onSurfaceVariant,
        size: 18,
      ),
      onTap: () => open(screen),
    );
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    dark
                        ? 'assets/logo-full-white-red.svg'
                        : 'assets/logo-red.svg',
                    height: 60,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'TECNI REPUESTOS',
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tilarán · Catálogo de demostración',
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            link('Inicio', Icons.home_outlined, const HomeScreen()),
            link(
              'Repuestos',
              Icons.build_outlined,
              const CategoryScreen(
                title: 'Repuestos',
                icon: Icons.build_outlined,
                type: 'spare',
              ),
            ),
            link(
              'Accesorios',
              Icons.sports_motorsports_outlined,
              const CategoryScreen(
                title: 'Accesorios',
                icon: Icons.sports_motorsports_outlined,
                type: 'accesorie',
              ),
            ),
            const Divider(indent: 20, endIndent: 20),
            link(
              'Mi carrito',
              Icons.shopping_cart_outlined,
              const MyCartScreen(),
            ),
            link(
              'Mis pedidos',
              Icons.inventory_2_outlined,
              const MyOrderScreen(),
            ),
            link('Mi perfil', Icons.person_outline, const UserProfileScreen()),
            const Divider(indent: 20, endIndent: 20),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text('ADMINISTRACIÓN · DEMO'),
            ),
            link(
              'Administrar usuarios',
              Icons.manage_accounts_outlined,
              const AdminUsersScreen(),
            ),
            link(
              'Administrar pedidos',
              Icons.inventory_outlined,
              const AdminUsersOrdersScreens(),
            ),
            link(
              'Administrar productos',
              Icons.edit_outlined,
              const DemoProductsPage(),
            ),
            link('Acceso de ejemplo', Icons.login, const DemoAuthForm()),
            const Divider(indent: 20, endIndent: 20),
            SwitchListTile(
              title: const Text('Tema oscuro'),
              secondary: Icon(
                dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                color: scheme.primary,
              ),
              value: dark,
              onChanged: (value) {
                final provider = context.read<ThemeProvider>();
                value ? provider.setDarkMode() : provider.setLigthMode();
                Preferences.isDarkmode = value;
              },
            ),
            link('Acerca de', Icons.info_outline, const AboutUsScreen()),
            link(
              'Modo prototipo',
              Icons.visibility_outlined,
              const DemoAccessScreen(),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Explora libremente. Todos los pedidos son simulados.',
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
