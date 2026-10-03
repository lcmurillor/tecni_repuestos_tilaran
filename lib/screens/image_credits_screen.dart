import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageCreditsScreen extends StatefulWidget {
  const ImageCreditsScreen({super.key});

  @override
  State<ImageCreditsScreen> createState() => _ImageCreditsScreenState();
}

class _ImageCreditsScreenState extends State<ImageCreditsScreen> {
  late final Future<List<dynamic>> credits = rootBundle
      .loadString('assets/products/credits.json')
      .then((text) => jsonDecode(text) as List<dynamic>);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Créditos de imágenes')),
        body: FutureBuilder<List<dynamic>>(
          future: credits,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('No se pudieron cargar los créditos.'));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('Imágenes ilustrativas de Wikimedia Commons. Cada imagen conserva su licencia original; no representa un modelo o compatibilidad específicos.'),
                const SizedBox(height: 16),
                for (final item in snapshot.data!)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(item['asset'] as String, height: 120, width: double.infinity, fit: BoxFit.contain),
                          const SizedBox(height: 12),
                          Text(item['product'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(item['title'] as String),
                          Text('Autor: ${item['author']}'),
                          Text(item['changes'] as String),
                          Wrap(
                            spacing: 8,
                            children: [
                              TextButton(onPressed: () => launchUrl(Uri.parse(item['source'] as String)), child: const Text('Ver fuente')),
                              TextButton(onPressed: () => launchUrl(Uri.parse((item['licenseUrl'] as String).isEmpty ? item['source'] as String : item['licenseUrl'] as String)), child: Text(item['license'] as String)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      );
}
