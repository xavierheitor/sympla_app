import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/upload/widgets/background_sync_status_widget.dart';
import 'package:sympla_app/modules/sync/sync_controller.dart';

class SyncStatusPage extends GetView<SyncController> {
  const SyncStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status de Sincronização'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.atualizarStatus,
            tooltip: 'Atualizar',
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody() {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Widget de status do background sync
            const BackgroundSyncStatusWidget(),

            const SizedBox(height: 24),

            // Seção de controles manuais
            _buildManualControlsSection(),

            const SizedBox(height: 24),

            // Seção de informações detalhadas
            _buildDetailedInfoSection(),

            const SizedBox(height: 24),

            // Seção de logs/status
            _buildLogsSection(),
          ],
        ),
      );
  }

  Widget _buildManualControlsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.settings, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Controles Manuais',
                  style: Get.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Obx(() => ElevatedButton.icon(
                        onPressed: controller.isLoading.value ? null : controller.iniciarServico,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Iniciar Serviço'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      )),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(() => ElevatedButton.icon(
                        onPressed: controller.isLoading.value ? null : controller.pararServico,
                        icon: const Icon(Icons.stop),
                        label: const Text('Parar Serviço'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Obx(() => ElevatedButton.icon(
                        onPressed: controller.isLoading.value ? null : controller.verificarManual,
                        icon: const Icon(Icons.search),
                        label: const Text('Verificar Atividades'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      )),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(() => ElevatedButton.icon(
                        onPressed: controller.isLoading.value ? null : controller.sincronizarManual,
                        icon: const Icon(Icons.cloud_upload),
                        label: const Text('Sincronizar Agora'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedInfoSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Informações Detalhadas',
                  style: Get.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Verificação Automática', 'A cada 15 minutos'),
            _buildInfoRow('Sincronização Automática', 'A cada 5 minutos'),
            _buildInfoRow('Tentativas Máximas', '3 por item'),
            _buildInfoRow('Requer Conexão', 'WiFi'),
            Obx(() =>
                _buildInfoRow('Status Atual', controller.estaExecutando ? 'Ativo' : 'Inativo')),
            Obx(() =>
                _buildInfoRow('Conexão', controller.temConexao ? 'Conectado' : 'Desconectado')),
            Obx(() => _buildInfoRow('Fila de Upload', '${controller.tamanhoFila} itens')),
            Obx(() => _buildInfoRow('Processando', controller.estaProcessando ? 'Sim' : 'Não')),
          ],
        ),
      ),
    );
  }

  Widget _buildLogsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.history, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Status em Tempo Real',
                  style: Get.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• Serviço: ${controller.estaExecutando ? "Ativo" : "Inativo"}',
                        style: TextStyle(
                          color: controller.estaExecutando ? Colors.green[700] : Colors.red[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '• Conexão: ${controller.temConexao ? "Conectado" : "Desconectado"}',
                        style: TextStyle(
                          color: controller.temConexao ? Colors.green[700] : Colors.orange[700],
                        ),
                      ),
                      Text(
                        '• Fila: ${controller.tamanhoFila} itens pendentes',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        '• Processamento: ${controller.estaProcessando ? "Em andamento" : "Ocioso"}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      if (controller.isLoading.value)
                        Text(
                          '• Operação em andamento...',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Obx(() => FloatingActionButton.extended(
          onPressed: controller.isLoading.value ? null : controller.sincronizarManual,
          icon: controller.isLoading.value
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(Icons.sync),
          label: Text(controller.isLoading.value ? 'Sincronizando...' : 'Sincronizar'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ));
  }
}
