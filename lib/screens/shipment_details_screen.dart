// Original interactive flow preserved in docs/shipment_details_screen-interactive-legacy.dart.txt.
import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'demo_customer_screen.dart';

class ShipmentDetailScreen extends StatelessWidget {
  const ShipmentDetailScreen({super.key, required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) => DemoCustomerShipmentPage(order: order);
}
