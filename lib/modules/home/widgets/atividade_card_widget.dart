import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/data/models/atividade_model.dart';
import 'package:sympla_app/modules/home/widgets/atividade_descricao_widget.dart';

class AtividadeCard extends StatelessWidget {
  final AtividadeModel atividade;

  const AtividadeCard({
    super.key,
    required this.atividade,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AtividadeController>();

    final status = atividade.status;
    final isConcluida = status == StatusAtividade.concluido;
    final isEmExecucao = status == StatusAtividade.emAndamento;

    final Color cardColor = switch (status) {
      StatusAtividade.pendente => Colors.blue[50]!,
      StatusAtividade.emAndamento => Colors.orange[50]!,
      StatusAtividade.concluido => Colors.green[50]!,
      StatusAtividade.cancelado => Colors.red[50]!,
      StatusAtividade.sincronizado => Colors.grey[200]!,
    };

    final Color chipColor = switch (status) {
      StatusAtividade.pendente => Colors.blue[100]!,
      StatusAtividade.emAndamento => Colors.orange[100]!,
      StatusAtividade.concluido => Colors.green[100]!,
      StatusAtividade.cancelado => Colors.red[100]!,
      StatusAtividade.sincronizado => Colors.grey[300]!,
    };

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: cardColor,
      child: Opacity(
        opacity: isConcluida ? 0.6 : 1.0,
        child: InkWell(
          onTap: isConcluida
              ? null
              : () async {
                  if (isEmExecucao) {
                    Get.toNamed('/apr');
                  } else {
                    if (controller.atividadeEmAndamento.value != null) {
                      Get.snackbar(
                        'Aviso',
                        'Já existe uma atividade em andamento. Finalize-a antes de iniciar outra.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      );
                      return;
                    }
                    _mostrarDialogoConfirmacao(context, atividade, controller);
                  }
                },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título e ícone
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        atividade.titulo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isConcluida)
                      const Icon(Icons.check_circle, color: Colors.green),
                  ],
                ),
                const SizedBox(height: 12),

                // Descrição
                Text(
                  atividade.descricao,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),

                // Informações adicionais
                Column(
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
                      value: atividade.nomeEquipamento ?? 'N/A',
                    ),
                    if (atividade.ordemServico.isNotEmpty)
                      AtividadeDescricaoItem(
                        icon: Icons.description,
                        label: 'OS',
                        value: atividade.ordemServico,
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Status
                Align(
                  alignment: Alignment.centerRight,
                  child: Chip(
                    label: Text(
                      atividade.status.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    backgroundColor: chipColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -2),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  Color _getCorDiasRestantes(DateTime dataLimite) {
    final hoje = DateTime.now();
    final diferenca = dataLimite.difference(hoje).inDays;

    if (diferenca < 0) {
      return Colors.red;
    } else if (diferenca <= 2) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  void _mostrarDialogoConfirmacao(BuildContext context,
      AtividadeModel atividade, AtividadeController controller) {
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
              Get.toNamed('/apr', arguments: atividade);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}
