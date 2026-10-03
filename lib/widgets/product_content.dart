import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/screens/demo_admin_screen.dart';

String productPrice(double price) => NumberFormat.currency(
  locale: 'es_CR',
  symbol: '₡',
  decimalDigits: 0,
).format(price);

class ProductPhoto extends StatelessWidget {
  const ProductPhoto({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: AspectRatio(
      aspectRatio: 1.8,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            product.imageUrl.startsWith('assets/')
                ? product.imageUrl
                : 'assets/placeholder-image.png',
            fit: BoxFit.contain,
            semanticLabel: product.description,
            errorBuilder: (_, _, _) =>
                const Icon(Icons.image_not_supported_outlined, size: 48),
          ),
        ),
      ),
    ),
  );
}

class ProductStock extends StatelessWidget {
  const ProductStock({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = product.quantity > 0
        ? scheme.tertiary
        : scheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        product.quantity > 0 ? '${product.quantity} disponibles' : 'Agotado',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class AddProductButton extends StatefulWidget {
  const AddProductButton({
    super.key,
    required this.product,
    this.compact = false,
  });
  final Product product;
  final bool compact;
  @override
  State<AddProductButton> createState() => _AddProductButtonState();
}

class _AddProductButtonState extends State<AddProductButton> {
  bool busy = false;
  Future<void> add() async {
    showAdminDemo(context);
  }

  @override
  Widget build(BuildContext context) {
    final onPressed = busy || widget.product.quantity == 0 ? null : add;
    if (widget.compact) {
      return IconButton.filled(
        tooltip: 'Agregar al carrito',
        onPressed: onPressed,
        icon: Icon(
          Icons.shopping_cart,
          color: onPressed == null
              ? Theme.of(context).colorScheme.onSurface.withValues(alpha: .38)
              : Theme.of(context).colorScheme.onPrimary,
        ),
      );
    }
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(
        Icons.shopping_cart,
        color: onPressed == null
            ? Theme.of(context).colorScheme.onSurface.withValues(alpha: .38)
            : Theme.of(context).colorScheme.onPrimary,
      ),
      label: Text(
        widget.product.quantity == 0 ? 'Sin existencias' : 'Agregar al carrito',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ProductDetailsContent extends StatelessWidget {
  const ProductDetailsContent({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductPhoto(product: product),
        const SizedBox(height: 20),
        Text(
          '${product.category.toUpperCase()} · ${product.code}',
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              productPrice(product.price),
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
            ProductStock(product: product),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          product.details.isEmpty
              ? 'Artículo del catálogo de demostración.'
              : product.details,
          style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () =>
              openDemoPage(context, DemoProductEditPage(product: product)),
          icon: const Icon(Icons.edit_outlined),
          label: const Text('Ver edición del producto (demo)'),
        ),
        const SizedBox(height: 24),
        Text(
          'Características',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        for (final entry in product.specifications.entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    entry.key,
                    style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        const Divider(height: 24),
        Text(
          'Ficha e imagen ilustrativas. Compatibilidad y características no verificadas; no se realizan compras reales.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: AddProductButton(product: product),
        ),
      ],
    );
  }
}
