import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';

class AnomaliaDetalhesWidget extends StatelessWidget {
  final AnomaliaTableDto anomalia;

  const AnomaliaDetalhesWidget({super.key, required this.anomalia});

  @override
  Widget build(BuildContext context) {
    final hasFoto = anomalia.foto != null && anomalia.foto!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${anomalia.codigoSapDefeito ?? "???"} - ${anomalia.codigoSapDefeito != null ? "" : "Defeito desconhecido"}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Equipamento: ${anomalia.nomeEquipamento ?? "Desconhecido"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: Text('Fase: ${anomalia.fase.name}')),
                Expanded(child: Text('Lado: ${anomalia.lado.name}')),
              ],
            ),
            const SizedBox(height: 12),
            if (anomalia.delta != null)
              Text('ΔT: ${anomalia.delta!.toStringAsFixed(2)} °C'),
            const SizedBox(height: 12),
            Text(
              'Observação: ${anomalia.observacao?.trim().isEmpty ?? true ? 'vazio' : anomalia.observacao!}',
            ),
            const SizedBox(height: 16),
            if (hasFoto)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Foto da anomalia',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        Uint8List.fromList(anomalia.foto!),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            backgroundColor: Colors.black,
                            insetPadding: const EdgeInsets.all(16),
                            child: InteractiveViewer(
                              panEnabled: true,
                              minScale: 0.5,
                              maxScale: 4,
                              child: Center(
                                child: Image.memory(
                                  Uint8List.fromList(anomalia.foto!),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.fullscreen),
                      label: const Text('Ver em tela cheia'),
                    ),
                  ),
                ],
              )
            else
              const Text('Nenhuma foto disponível.'),
          ],
        ),
      ),
    );
  }
}
