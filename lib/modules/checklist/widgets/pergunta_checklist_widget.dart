import 'package:flutter/material.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';
import 'package:sympla_app/core/storage/app_database.dart';

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
            Wrap(
              spacing: 12,
              children: RespostaChecklist.values.map((opcao) {
                final selecionado = resposta == opcao;
                return ChoiceChip(
                  label: Text(opcao.name.toUpperCase()),
                  selected: selecionado,
                  onSelected: (_) => onSelecionar(opcao),
                  selectedColor: Colors.blueAccent,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
