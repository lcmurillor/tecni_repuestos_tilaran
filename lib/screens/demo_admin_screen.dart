import 'package:flutter/material.dart';
import 'package:tecni_repuestos/Services/services.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/widgets/product_content.dart';

void showAdminDemo(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      const SnackBar(
        showCloseIcon: true,
        duration: Duration(seconds: 3),
        content: Text(
          'Modo demo: esta acción es solo ilustrativa. No se modifican datos.',
        ),
      ),
    );
}

void openDemoPage(BuildContext context, Widget page) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));

class DemoAdminPage extends StatelessWidget {
  const DemoAdminPage({super.key, required this.title, required this.children});
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title, style: const TextStyle(fontSize: 18))),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            'DEMO · SOLO LECTURA\nExplora las pantallas y acciones del sistema. Los datos son ficticios; no se guardan cambios.',
          ),
        ),
        const SizedBox(height: 20),
        ...children,
        const SizedBox(height: 24),
      ],
    ),
  );
}

class DemoField extends StatelessWidget {
  const DemoField(this.label, this.value, {super.key});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextFormField(
      initialValue: value,
      readOnly: true,
      showCursor: false,
      maxLines: null,
      onTap: () => showAdminDemo(context),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.lock_outline, size: 18),
      ),
    ),
  );
}

Widget demoAction(BuildContext context, String label, IconData icon) => Padding(
  padding: const EdgeInsets.only(bottom: 12),
  child: OutlinedButton.icon(
    onPressed: () => showAdminDemo(context),
    icon: Icon(icon),
    label: Text(label, textAlign: TextAlign.center),
  ),
);

List<User> demoAdminUsers() => (DemoDatabase.instance.read('users') as Map)
    .values
    .map((row) => User.fromJson(jsonEncode(row)))
    .toList();

// Detached snapshots: browsing administration never writes to the local database.
List<Order> demoAdminOrders([User? user]) {
  final all = (DemoDatabase.instance.read('orders') as Map).values
      .map((row) => Order.fromJson(jsonEncode(row)))
      .toList();
  final selected = all
      .where((order) => user == null || order.user['id'] == user.id)
      .toList();
  if (selected.isEmpty) return selected;
  final sample = selected.first;
  return [
    ...selected,
    for (var status = 1; status <= 5; status++)
      Order.fromMap({
        ...sample.toMap(),
        'id': 'EJEMPLO-ETAPA-$status',
        'status': status,
      }),
  ];
}

const demoOrderStages = [
  'Pendiente',
  'En proceso',
  'Enviado',
  'En camino',
  'Entregado',
];

class DemoUsersPage extends StatelessWidget {
  const DemoUsersPage({super.key});
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Administrar usuarios',
    children: [
      demoAction(context, 'Agregar usuario', Icons.person_add_outlined),
      for (final user in demoAdminUsers())
        Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text('${user.name} ${user.lastname}'),
            subtitle: Text(
              '${user.email}\n${user.administrator
                  ? 'Administrador'
                  : user.vendor
                  ? 'Vendedor'
                  : 'Cliente'}',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => openDemoPage(context, DemoUserPage(user: user)),
          ),
        ),
    ],
  );
}

class DemoUserPage extends StatelessWidget {
  const DemoUserPage({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Detalle del usuario',
    children: [
      DemoField('Nombre', '${user.name} ${user.lastname}'),
      DemoField('Correo electrónico', user.email),
      DemoField('Teléfono', user.phone),
      DemoField('Identificación', user.identification),
      DemoField('Estado', user.disabled ? 'Deshabilitado' : 'Activo'),
      FilledButton.icon(
        onPressed: () => openDemoPage(context, DemoOrdersPage(user: user)),
        icon: const Icon(Icons.inventory_2_outlined),
        label: const Text('Gestionar pedidos'),
      ),
      const SizedBox(height: 12),
      OutlinedButton.icon(
        onPressed: () => openDemoPage(context, DemoUserRolesPage(user: user)),
        icon: const Icon(Icons.manage_accounts_outlined),
        label: const Text('Cambiar rol del usuario'),
      ),
      const SizedBox(height: 12),
      demoAction(context, 'Guardar usuario', Icons.save_outlined),
      demoAction(
        context,
        user.disabled ? 'Habilitar usuario' : 'Deshabilitar usuario',
        Icons.block,
      ),
      demoAction(context, 'Eliminar usuario', Icons.delete_outline),
    ],
  );
}

class DemoUserRolesPage extends StatelessWidget {
  const DemoUserRolesPage({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    final current = user.administrator
        ? 'Administrador'
        : user.vendor
        ? 'Vendedor'
        : 'Cliente';
    return DemoAdminPage(
      title: 'Roles del usuario',
      children: [
        Text(
          '${user.name} ${user.lastname}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        for (final role in ['Cliente', 'Vendedor', 'Administrador'])
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              role == current
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
            ),
            title: Text(role),
            subtitle: Text(
              role == 'Cliente'
                  ? 'Catálogo y pedidos propios'
                  : role == 'Vendedor'
                  ? 'Productos y seguimiento de pedidos'
                  : 'Usuarios, catálogo y pedidos',
            ),
            onTap: () => showAdminDemo(context),
          ),
        demoAction(context, 'Aplicar rol', Icons.check),
      ],
    );
  }
}

class DemoOrdersPage extends StatefulWidget {
  const DemoOrdersPage({super.key, this.user});
  final User? user;
  @override
  State<DemoOrdersPage> createState() => _DemoOrdersPageState();
}

class _DemoOrdersPageState extends State<DemoOrdersPage> {
  int filter = 0;
  @override
  Widget build(BuildContext context) {
    final orders = demoAdminOrders(widget.user)
        .where(
          (o) => filter == 0 || (filter == 1 ? o.status < 5 : o.status == 5),
        )
        .toList();
    return DemoAdminPage(
      title: 'Administrar pedidos',
      children: [
        if (widget.user != null)
          Text('Pedidos de ${widget.user!.name} ${widget.user!.lastname}'),
        const Text(
          'Incluye ejemplos de cada etapa para recorrer el flujo completo.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            for (var i = 0; i < 3; i++)
              ChoiceChip(
                label: Text(['Todos', 'Pendientes', 'Entregados'][i]),
                selected: filter == i,
                onSelected: (_) => setState(() => filter = i),
              ),
          ],
        ),
        const SizedBox(height: 16),
        demoAction(context, 'Agregar pedido', Icons.add),
        if (orders.isEmpty)
          const Text('Este usuario no tiene pedidos de ejemplo.'),
        for (final order in orders)
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(order.id),
              subtitle: Text(
                '${order.user['name']} ${order.user['lastname']}\n${demoOrderStages[(order.status - 1).clamp(0, 4)]}',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => openDemoPage(context, DemoOrderPage(order: order)),
            ),
          ),
      ],
    );
  }
}

class DemoOrderPage extends StatelessWidget {
  const DemoOrderPage({super.key, required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Detalle del pedido',
    children: [
      Text(order.id, style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 16),
      DemoField('Cliente', '${order.user['name']} ${order.user['lastname']}'),
      DemoField(
        'Dirección de entrega',
        '${order.address['canton']}, ${order.address['province']}\n${order.address['address']}',
      ),
      for (final cart in order.carts.values)
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('${cart['description']}'),
          subtitle: Text(
            'Cantidad: ${cart['quantity']} · ${productPrice((cart['total'] as num).toDouble())}',
          ),
        ),
      const Divider(height: 32),
      Text('Flujo del pedido', style: Theme.of(context).textTheme.titleLarge),
      for (var i = 0; i < demoOrderStages.length; i++)
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            order.status >= i + 1
                ? Icons.check_circle_outline
                : Icons.radio_button_unchecked,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          title: Text(demoOrderStages[i]),
          subtitle: Text(
            order.status == i + 1
                ? 'Etapa actual'
                : order.status > i + 1
                ? 'Completada'
                : 'Siguiente etapa',
          ),
        ),
      demoAction(context, 'Procesar pedido', Icons.pending_actions),
      OutlinedButton.icon(
        onPressed: () => openDemoPage(context, DemoShippingPage(order: order)),
        icon: const Icon(Icons.local_shipping_outlined),
        label: const Text('Preparar envío'),
      ),
      const SizedBox(height: 12),
      demoAction(context, 'Marcar en camino', Icons.route_outlined),
      demoAction(context, 'Marcar entregado', Icons.task_alt),
      demoAction(context, 'Cancelar pedido', Icons.cancel_outlined),
    ],
  );
}

class DemoShippingPage extends StatelessWidget {
  const DemoShippingPage({super.key, required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Preparar envío',
    children: [
      DemoField('Pedido', order.id),
      DemoField('Medio de envío', order.shippingMethod),
      DemoField('Código de seguimiento', order.shippingCode),
      DemoField(
        'Fecha estimada',
        DateTime.fromMillisecondsSinceEpoch(
          order.arrivelDate,
        ).toIso8601String().split('T').first,
      ),
      demoAction(context, 'Adjuntar comprobante', Icons.attach_file),
      demoAction(context, 'Confirmar envío', Icons.local_shipping_outlined),
    ],
  );
}

class DemoProductsPage extends StatelessWidget {
  const DemoProductsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final products = (DemoDatabase.instance.read('products') as Map).values.map(
      (row) => Product.fromJson(jsonEncode(row)),
    );
    return DemoAdminPage(
      title: 'Administrar productos',
      children: [
        demoAction(context, 'Agregar producto', Icons.add),
        for (final product in products)
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Image.asset(
                product.imageUrl,
                width: 48,
                height: 48,
                fit: BoxFit.contain,
              ),
              title: Text(product.description),
              subtitle: Text(
                '${product.code} · ${product.quantity} disponibles',
              ),
              trailing: const Icon(Icons.edit_outlined),
              onTap: () =>
                  openDemoPage(context, DemoProductEditPage(product: product)),
            ),
          ),
      ],
    );
  }
}

class DemoProductEditPage extends StatelessWidget {
  const DemoProductEditPage({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) => DemoAdminPage(
    title: 'Editar producto',
    children: [
      ProductPhoto(product: product),
      const SizedBox(height: 16),
      demoAction(context, 'Cambiar imagen', Icons.add_photo_alternate_outlined),
      DemoField('Nombre del producto', product.description),
      DemoField('Código', product.code),
      DemoField('Categoría', product.category),
      DemoField('Tipo', product.type == 'spare' ? 'Repuesto' : 'Accesorio'),
      DemoField('Costo', productPrice(product.cost)),
      DemoField('Precio', productPrice(product.price)),
      DemoField('Disponibles', '${product.quantity}'),
      DemoField('Localización', product.location),
      DemoField('Descripción', product.details),
      for (final spec in product.specifications.entries)
        DemoField(spec.key, spec.value),
      demoAction(context, 'Guardar cambios', Icons.save_outlined),
      demoAction(context, 'Eliminar producto', Icons.delete_outline),
    ],
  );
}
