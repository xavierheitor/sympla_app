import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_table_dto.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';
import 'package:sympla_app/modules/checklist/anomalias/adicionar_anomalia_page.dart';
import 'package:sympla_app/modules/checklist/anomalias/anomalia_controller.dart';
import 'package:sympla_app/modules/checklist/checklist_controller.dart';

class PerguntaChecklistWidget extends StatelessWidget {
  final ChecklistPerguntaTableDto pergunta;
  final ValueChanged<RespostaChecklist> onSelecionar;

  const PerguntaChecklistWidget({
    super.key,
    required this.pergunta,
    required this.onSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    final checklistController = Get.find<ChecklistController>();
    final anomaliaController = Get.find<AnomaliaController>();

    return Obx(() {
      final resposta = checklistController.respostas[pergunta.uuid];
      final isNok = resposta == RespostaChecklist.nok;
      final observacaoController = TextEditingController();
      final anomalias = anomaliaController.buscarAnomalias(pergunta.uuid);

      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pergunta.pergunta,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: RespostaChecklist.values.map((opcao) {
                  final selecionado = resposta == opcao;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(opcao.name.toUpperCase(),
                            textAlign: TextAlign.center),
                        selected: selecionado,
                        onSelected: (_) => onSelecionar(opcao),
                        selectedColor: Colors.blueAccent,
                      ),
                    ),
                  );
                }).toList(),
              ),
              if (isNok) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: observacaoController,
                  decoration: const InputDecoration(
                    labelText: 'Observação',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    await Get.to(() => AdicionarAnomaliaPage(
                          perguntaId: pergunta.uuid,
                        ));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar Anomalia'),
                ),
                const SizedBox(height: 12),
                if (anomalias.isEmpty)
                  const Text(
                    '📌 Nenhuma anomalia adicionada',
                    style: TextStyle(color: Colors.red),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: anomalias.map((a) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          '📌 ${a.defeitoId} - ${a.observacao?.trim().isEmpty == true ? "Sem observação" : a.observacao}',
                          style: const TextStyle(color: Colors.black87),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ],
          ),
        ),
      );
    });
  }
}
