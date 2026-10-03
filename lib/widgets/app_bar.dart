import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'search_delegate.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(64);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final value = await LocalDataService.getCartCount();
      if (mounted) context.read<MyCartInfoProvider>().setCount(count: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final count = context.watch<MyCartInfoProvider>().getCount();
    return AppBar(
      toolbarHeight: 64,
      titleSpacing: 0,
      leading: IconButton(
        tooltip: 'Abrir menú',
        icon: const Icon(Icons.menu_rounded),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: Material(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () =>
              showSearch(context: context, delegate: ProductsSearchDelegate()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.search, color: scheme.primary, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Buscar productos',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Badge(
            isLabelVisible: count > 0,
            label: Text('$count'),
            backgroundColor: scheme.tertiary,
            textColor: scheme.onTertiary,
            child: IconButton(
              tooltip: 'Mi carrito',
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, 'myCart'),
            ),
          ),
        ),
      ],
    );
  }
}
