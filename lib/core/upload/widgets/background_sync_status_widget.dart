import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/upload/background_sync_service.dart';

/// Widget para mostrar o status do BackgroundSyncService
class BackgroundSyncStatusWidget extends StatelessWidget {
  const BackgroundSyncStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.sync, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Sincronização em Background',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildStatusRow('Status', 'Ativo'),
            _buildStatusRow('Conexão', 'Verificando...'),
            _buildStatusRow('Fila', '0 itens'),
            _buildStatusRow('Processando', 'Não'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _verificarManual(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Verificar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _sincronizarManual(),
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text('Sincronizar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _verificarManual() {
    try {
      final service = Get.find<BackgroundSyncService>();
      service.verificarManual();
    } catch (e) {
      // Serviço não disponível
    }
  }

  void _sincronizarManual() {
    try {
      final service = Get.find<BackgroundSyncService>();
      service.sincronizarManual();
    } catch (e) {
      // Serviço não disponível
    }
  }

  Widget _buildStatusRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(value),
        ],
      ),
    );
  }
}
