import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/modules/home/widgets/atividade_descricao_widget.dart';
class AtividadeCard extends StatelessWidget {
  final AtividadeTableDto atividade;

  const AtividadeCard({super.key, required this.atividade});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AtividadeController>();

    return Obx(() {
      final atualizada = controller.atividades
              .firstWhereOrNull((a) => a.uuid == atividade.uuid) ??
          atividade;

      final status = atualizada.status;
      final isConcluida = status == StatusAtividade.concluido;
      final isEmExecucao = status == StatusAtividade.emAndamento;


      final cardColor = switch (status) {
        StatusAtividade.pendente => Colors.blue[50]!,
        StatusAtividade.emAndamento => Colors.orange[50]!,
        StatusAtividade.concluido => Colors.green[50]!,
        StatusAtividade.cancelado => Colors.red[50]!,
        StatusAtividade.sincronizado => Colors.grey[200]!,
        StatusAtividade.pendenteUpload => Colors.yellow[50]!,
        StatusAtividade.erroUpload => Colors.red[50]!,
      };

      final chipColor = switch (status) {
        StatusAtividade.pendente => Colors.blue[100]!,
        StatusAtividade.emAndamento => Colors.orange[100]!,
        StatusAtividade.concluido => Colors.green[100]!,
        StatusAtividade.cancelado => Colors.red[100]!,
        StatusAtividade.sincronizado => Colors.grey[300]!,
        StatusAtividade.pendenteUpload => Colors.yellow[100]!,
        StatusAtividade.erroUpload => Colors.red[100]!,
      };

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        color: cardColor,
        child: Opacity(
          opacity: isConcluida ? 0.6 : 1.0,
          child: InkWell(
            onTap: _podeAbrirAtividade(status)
                ? () async {
                    final atual = controller.atividadeEmAndamento.value;
                    if (isEmExecucao) {
                      await controller.executarAtividade(atividade);
                      return;
                    }
                    if (atual != null) {
                      Get.snackbar(
                        'Aviso',
                        'Já existe uma atividade em andamento.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      );
                      return;
                    }
                    _mostrarDialogoConfirmacao(context, atividade, controller);
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCabecalho(atividade, isConcluida),
                  const SizedBox(height: 12),
                  Text(atividade.descricao,
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 12),
                  _buildDescricao(atividade),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Chip(
                      label: Text(
                        atividade.status.name,
                        style: const TextStyle(fontSize: 12),
                      ),
                      backgroundColor: chipColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCabecalho(AtividadeTableDto atividade, bool isConcluida) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(atividade.titulo,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        if (isConcluida)
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
      ],
    );
  }

  Widget _buildDescricao(AtividadeTableDto atividade) {
    return Column(
      children: [
        AtividadeDescricaoItem(
          icon: Icons.calendar_today,
          label: 'Data Limite',
          value: _formatarData(atividade.dataLimite),
          valueStyle: TextStyle(
            color: _getCorDiasRestantes(atividade.dataLimite),
            fontWeight: FontWeight.bold,
          ),
        ),
        AtividadeDescricaoItem(
          icon: Icons.location_on,
          label: 'Subestação',
          value: atividade.subestacao,
        ),
        AtividadeDescricaoItem(
          icon: Icons.build,
          label: 'Equipamento',
          value: atividade.equipamento?.nome ?? 'N/A',
        ),
        if (atividade.ordemServico.isNotEmpty)
          AtividadeDescricaoItem(
            icon: Icons.description,
            label: 'OS',
            value: atividade.ordemServico,
          ),
      ],
    );
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  Color _getCorDiasRestantes(DateTime dataLimite) {
    final hoje = DateTime.now();
    final diferenca = dataLimite.difference(hoje).inDays;
    if (diferenca < 0) return Colors.red;
    if (diferenca <= 2) return Colors.orange;
    return Colors.green;
  }

  void _mostrarDialogoConfirmacao(BuildContext context,
      AtividadeTableDto atividade, AtividadeController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Execução'),
        content: Text(
            'Deseja iniciar a execução da atividade: ${atividade.titulo}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await controller.iniciarAtividade(atividade);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  /// Verifica se a atividade pode ser aberta baseado no status
  bool _podeAbrirAtividade(StatusAtividade status) {
    return status == StatusAtividade.pendente || status == StatusAtividade.emAndamento;
  }
}
