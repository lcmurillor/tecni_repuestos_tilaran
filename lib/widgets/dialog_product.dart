import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'product_content.dart';

// El flujo antiguo de carga de imágenes se conserva en docs/dialog_product-legacy.dart.txt.
class DialogProdcut {
  static Future<void> displayProductDialog(
    BuildContext context,
    Product product,
  ) => showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 440,
          maxHeight: MediaQuery.sizeOf(context).height * .9,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  tooltip: 'Cerrar detalle',
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ),
              ProductDetailsContent(product: product),
            ],
          ),
        ),
      ),
    ),
  );
}
