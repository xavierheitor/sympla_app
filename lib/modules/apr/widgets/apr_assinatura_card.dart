import 'dart:typed_data';
import 'package:flutter/material.dart';

class AprAssinaturaCard extends StatelessWidget {
  final String nomeTecnico;
  final Uint8List assinaturaBytes;

  const AprAssinaturaCard({
    super.key,
    required this.nomeTecnico,
    required this.assinaturaBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(nomeTecnico),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Assinatura de $nomeTecnico'),
              content: Image.memory(
                assinaturaBytes,
                height: 200,
                fit: BoxFit.contain,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fechar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
