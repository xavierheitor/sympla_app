import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/modules/checklist/anomalia_controller.dart';
import 'package:sympla_app/modules/checklist/widgets/adicionar_anomalia_page.dart';

class PerguntaChecklistWidget extends StatelessWidget {
  final ChecklistPerguntaTableData pergunta;
  final RespostaChecklist? resposta;
  final ValueChanged<RespostaChecklist> onSelecionar;

  const PerguntaChecklistWidget({
    super.key,
    required this.pergunta,
    required this.resposta,
    required this.onSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    final isNok = resposta == RespostaChecklist.nok;
    final observacaoController = TextEditingController();
    final anomaliaController = Get.find<AnomaliaController>();
    final anomalias = anomaliaController.buscarAnomalias(pergunta.id);

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
                        perguntaId: pergunta.id,
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
                        '📌 ${a.defeitoId.value} - ${a.observacao.value?.trim().isEmpty == true ? "Sem observação" : a.observacao.value}',
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
  }
}
