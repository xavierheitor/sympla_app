import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CampoTexto({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
