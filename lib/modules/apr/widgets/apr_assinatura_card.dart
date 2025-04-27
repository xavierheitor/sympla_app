import 'dart:typed_data';
import 'package:flutter/material.dart';

class AprAssinaturaCard extends StatelessWidget {
  final Uint8List assinaturaBytes;

  const AprAssinaturaCard({
    super.key,
    required this.assinaturaBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.memory(
          assinaturaBytes,
          height: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
