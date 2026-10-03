import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/widgets/product_content.dart';
import 'demo_admin_screen.dart';

class DemoCartPage extends StatelessWidget {
  const DemoCartPage({super.key});
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Mi carrito',
    children: [
      const Text('Carrito de ejemplo · 2 artículos'),
      const SizedBox(height: 16),
      for (final item in [
        ('Filtro de aceite universal', 4500.0),
        ('Bujía de encendido', 3500.0),
      ])
        Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(item.$1, style: Theme.of(context).textTheme.titleMedium),
                Text('Cantidad: 1 · ${productPrice(item.$2)}'),
                Wrap(
                  children: [
                    IconButton(
                      tooltip: 'Aumentar cantidad',
                      onPressed: () => showAdminDemo(context),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                    IconButton(
                      tooltip: 'Reducir cantidad',
                      onPressed: () => showAdminDemo(context),
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    IconButton(
                      tooltip: 'Eliminar del carrito',
                      onPressed: () => showAdminDemo(context),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      const DemoField('Subtotal', '₡8.000'),
      const DemoField('IVA (13 %)', '₡1.040'),
      const DemoField('Total', '₡9.040'),
      OutlinedButton.icon(
        onPressed: () => openDemoPage(context, const DemoAddressesPage()),
        icon: const Icon(Icons.location_on_outlined),
        label: const Text('Ver dirección de entrega'),
      ),
      const SizedBox(height: 12),
      demoAction(context, 'Vaciar carrito', Icons.delete_sweep_outlined),
      FilledButton(
        onPressed: () => openDemoPage(context, const DemoCheckoutPage()),
        child: const Text('Ver flujo de pedido'),
      ),
    ],
  );
}

class DemoCheckoutPage extends StatelessWidget {
  const DemoCheckoutPage({super.key});
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Pedido de demostración',
    children: [
      const Text(
        'Vista del paso de confirmación',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 12),
      const Text(
        'En la aplicación original se confirmaba el pedido y se adjuntaba un comprobante. Aquí puedes recorrer esas pantallas con un ejemplo fijo.',
      ),
      const SizedBox(height: 16),
      const DemoField('Código de ejemplo', 'DEMO-EJEMPLO'),
      const DemoField('Total de ejemplo', '₡9.040'),
      demoAction(context, 'Confirmar pedido', Icons.check_circle_outline),
      OutlinedButton(
        onPressed: () => openDemoPage(context, const DemoReceiptPage()),
        child: const Text('Ver envío de comprobante'),
      ),
      const SizedBox(height: 12),
      FilledButton(
        onPressed: () => openDemoPage(context, const DemoCustomerOrdersPage()),
        child: const Text('Ver mis pedidos'),
      ),
    ],
  );
}

class DemoReceiptPage extends StatelessWidget {
  const DemoReceiptPage({super.key});
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Enviar comprobante',
    children: [
      const Icon(Icons.receipt_long_outlined, size: 72),
      const SizedBox(height: 16),
      const Text(
        'Vista previa del comprobante de pago. No se reciben archivos ni se realizan pagos.',
      ),
      const SizedBox(height: 16),
      demoAction(context, 'Agregar imagen', Icons.add_photo_alternate_outlined),
      demoAction(context, 'Enviar comprobante', Icons.upload_outlined),
    ],
  );
}

class DemoAddressesPage extends StatelessWidget {
  const DemoAddressesPage({super.key});
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Direcciones de facturación',
    children: [
      const DemoField(
        'Dirección de ejemplo',
        'Tilarán, Guanacaste\nDirección ficticia para demostración',
      ),
      OutlinedButton(
        onPressed: () => openDemoPage(context, const DemoAddressForm()),
        child: const Text('Editar dirección'),
      ),
      const SizedBox(height: 12),
      demoAction(context, 'Eliminar dirección', Icons.delete_outline),
      FilledButton(
        onPressed: () =>
            openDemoPage(context, const DemoAddressForm(isNew: true)),
        child: const Text('Agregar dirección'),
      ),
    ],
  );
}

class DemoAddressForm extends StatelessWidget {
  const DemoAddressForm({super.key, this.isNew = false});
  final bool isNew;
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: isNew ? 'Agregar dirección' : 'Editar dirección',
    children: [
      const DemoField('Dirección', 'Dirección ficticia para demostración'),
      const DemoField('Cantón', 'Tilarán'),
      const DemoField('Provincia', 'Guanacaste'),
      demoAction(context, 'Guardar dirección', Icons.save_outlined),
    ],
  );
}

class DemoProfileForm extends StatelessWidget {
  const DemoProfileForm({super.key});
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Editar mi información',
    children: [
      const DemoField('Nombre', 'Visitante'),
      const DemoField('Apellidos', 'Demo'),
      const DemoField('Teléfono', '00000000'),
      const DemoField('Fecha de nacimiento', '01/01/2000'),
      demoAction(context, 'Guardar información', Icons.save_outlined),
    ],
  );
}

class DemoAuthForm extends StatelessWidget {
  const DemoAuthForm({super.key, this.mode = 'login'});
  final String mode;
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: switch (mode) {
      'register' => 'Registro',
      'change' => 'Cambiar contraseña',
      'recover' => 'Recuperar contraseña',
      _ => 'Iniciar sesión',
    },
    children: [
      const Text('Acceso ilustrativo: no se solicitan credenciales reales.'),
      const SizedBox(height: 16),
      if (mode == 'register') ...[
        const DemoField('Nombre', 'Visitante'),
        const DemoField('Apellidos', 'Demo'),
      ],
      const DemoField('Correo electrónico', 'demo@example.com'),
      if (mode != 'recover')
        const DemoField('Contraseña de ejemplo', '••••••••'),
      if (mode == 'register' || mode == 'change')
        const DemoField('Confirmar contraseña', '••••••••'),
      demoAction(context, switch (mode) {
        'register' => 'Crear cuenta',
        'change' => 'Aplicar cambio',
        'recover' => 'Solicitar enlace',
        _ => 'Iniciar sesión',
      }, Icons.lock_outline),
      if (mode == 'login') ...[
        TextButton(
          onPressed: () =>
              openDemoPage(context, const DemoAuthForm(mode: 'register')),
          child: const Text('Ver registro'),
        ),
        TextButton(
          onPressed: () =>
              openDemoPage(context, const DemoAuthForm(mode: 'recover')),
          child: const Text('Olvidé mi contraseña'),
        ),
      ],
    ],
  );
}

class DemoCustomerOrdersPage extends StatelessWidget {
  const DemoCustomerOrdersPage({super.key});
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Mis pedidos',
    children: [
      for (final order in demoAdminOrders(demoAdminUsers().first))
        ListTile(
          title: Text(order.id),
          subtitle: Text(demoOrderStages[(order.status - 1).clamp(0, 4)]),
          trailing: const Icon(Icons.chevron_right),
          onTap: () =>
              openDemoPage(context, DemoCustomerShipmentPage(order: order)),
        ),
    ],
  );
}

class DemoCustomerShipmentPage extends StatelessWidget {
  const DemoCustomerShipmentPage({super.key, required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Detalles del envío',
    children: [
      DemoField('Pedido', order.id),
      DemoField('Medio de envío', order.shippingMethod),
      DemoField('Código guía', order.shippingCode),
      for (var i = 0; i < 5; i++)
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            order.status >= i + 1
                ? Icons.check_circle_outline
                : Icons.radio_button_unchecked,
          ),
          title: Text(demoOrderStages[i]),
        ),
      demoAction(context, 'Confirmar recibido', Icons.task_alt),
    ],
  );
}
