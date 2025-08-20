import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/upload/background_sync_service.dart';
import 'package:sympla_app/core/upload/upload_manager.dart';

/// Widget para mostrar o status do BackgroundSyncService
class BackgroundSyncStatusWidget extends StatelessWidget {
  const BackgroundSyncStatusWidget({super.key});

  /// Widget compacto para mostrar na tela principal
  static Widget compact() {
    return _CompactSyncStatusWidget();
  }

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
            _buildReactiveStatusRows(),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _verificarManual,
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
                    onPressed: _sincronizarManual,
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

  Widget _buildReactiveStatusRows() {
    // Evita triggers durante build juntando em um único Obx
    return Obx(() {
      return Column(
        children: [
          _buildStatusRow('Status', _getStatusText()),
          _buildStatusRow('Conexão', _getConexaoText()),
          _buildStatusRow('Fila', _getFilaText()),
          _buildStatusRow('Processando', _getProcessandoText()),
        ],
      );
    });
  }

  String _getStatusText() {
    try {
      final service = Get.find<BackgroundSyncService>();
      return service.executandoRx.value ? 'Ativo' : 'Inativo';
    } catch (e) {
      return 'Indisponível';
    }
  }

  String _getConexaoText() {
    try {
      final service = Get.find<BackgroundSyncService>();
      return service.temConexaoRx.value ? 'Conectado' : 'Desconectado';
    } catch (e) {
      return 'Verificando...';
    }
  }

  String _getFilaText() {
    try {
      final uploadManager = Get.find<UploadManager>();
      return '${uploadManager.tamanhoFilaRx.value} itens';
    } catch (e) {
      return '0 itens';
    }
  }

  String _getProcessandoText() {
    try {
      final uploadManager = Get.find<UploadManager>();
      return uploadManager.estaProcessandoRx.value ? 'Sim' : 'Não';
    } catch (e) {
      return 'Não';
    }
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

/// Widget compacto para mostrar na tela principal
class _CompactSyncStatusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
        // Recalcula sempre que UploadManager notificar
        final color = _getStatusColor();
        final text = _getStatusText();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_upload,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
    });
  }

  String _getStatusText() {
    try {
      final uploadManager = Get.find<UploadManager>();
      if (uploadManager.estaProcessandoRx.value) {
        return 'Sincronizando...';
      } else if (uploadManager.tamanhoFilaRx.value > 0) {
        return '${uploadManager.tamanhoFilaRx.value} pendente(s)';
      } else {
        return 'Sincronizado';
      }
    } catch (e) {
      return 'Indisponível';
    }
  }

  Color _getStatusColor() {
    try {
      final uploadManager = Get.find<UploadManager>();
      if (uploadManager.estaProcessandoRx.value) {
        return Colors.orange;
      } else if (uploadManager.tamanhoFilaRx.value > 0) {
        return Colors.red;
      } else {
        return Colors.green;
      }
    } catch (e) {
      return Colors.grey;
    }
  }
}
