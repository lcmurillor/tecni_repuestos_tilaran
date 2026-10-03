import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });
  final VoidCallback? onPressed;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(text),
      trailing: const Icon(Icons.chevron_right),
      onTap: onPressed,
    ),
  );
}
