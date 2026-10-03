import 'package:flutter/material.dart';

class DemoAccessScreen extends StatelessWidget {
  const DemoAccessScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Acceso de demostración')),
    body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.visibility_outlined, size: 64),
              const SizedBox(height: 24),
              const Text(
                'Estás explorando un prototipo',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Puedes navegar por el catálogo, ver el carrito de ejemplo y recorrer pedidos sin registrarte. El inicio de sesión y las contraseñas están deshabilitados.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  'home',
                  (_) => false,
                ),
                child: const Text('Explorar catálogo'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
