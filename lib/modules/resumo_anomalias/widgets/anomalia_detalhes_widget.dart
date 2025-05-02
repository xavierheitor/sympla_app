// anomalia_detalhes_widget.dart
import 'package:flutter/material.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/core/storage/converters/lado_converter.dart';
import 'dart:typed_data';

class AnomaliaDetalhesWidget extends StatelessWidget {
  final AnomaliaTableData anomalia;

  const AnomaliaDetalhesWidget({super.key, required this.anomalia});

  @override
  Widget build(BuildContext context) {
    final hasFoto = anomalia.foto != null && anomalia.foto!.isNotEmpty;

    AppLogger.d(
        '[AnomaliaDetalhesWidget] Exibindo detalhes da anomalia ID: ${anomalia.id}');
    AppLogger.d(
        '[AnomaliaDetalhesWidget] Dados: defeitoId=${anomalia.defeitoId}, equipamentoId=${anomalia.equipamentoId}, fase=${anomalia.fase}, lado=${anomalia.lado}, delta=${anomalia.delta}, obs=${anomalia.observacao}, foto?=${hasFoto}');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            title: const Text('Defeito'),
            subtitle: Text('ID: ${anomalia.defeitoId}'),
          ),
          ListTile(
            title: const Text('Equipamento'),
            subtitle: Text('ID: ${anomalia.equipamentoId}'),
          ),
          ListTile(
            title: const Text('Fase'),
            subtitle: Text(anomalia.fase.label),
          ),
          ListTile(
            title: const Text('Lado'),
            subtitle: Text(anomalia.lado.label),
          ),
          if (anomalia.delta != null)
            ListTile(
              title: const Text('Delta T'),
              subtitle: Text('${anomalia.delta!.toStringAsFixed(2)} °C'),
            ),
          if (anomalia.observacao != null && anomalia.observacao!.isNotEmpty)
            ListTile(
              title: const Text('Observação'),
              subtitle: Text(anomalia.observacao!),
            ),
          if (hasFoto)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Foto',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Image.memory(
                  Uint8List.fromList(anomalia.foto!),
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ],
            )
          else
            const Text('Nenhuma foto disponível.'),
        ],
      ),
    );
  }
}
