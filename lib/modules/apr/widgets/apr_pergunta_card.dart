import 'package:flutter/material.dart';
import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';

class AprPerguntaCard extends StatelessWidget {
  final String pergunta;
  final RespostaApr? respostaSelecionada;
  final ValueChanged<RespostaApr?> onRespostaSelecionada;

  const AprPerguntaCard({
    super.key,
    required this.pergunta,
    required this.respostaSelecionada,
    required this.onRespostaSelecionada,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pergunta,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: RespostaApr.values.map((resposta) {
                final isSelected = respostaSelecionada == resposta;

                return ChoiceChip(
                  label: Text(resposta.label),
                  selected: isSelected,
                  onSelected: (_) => onRespostaSelecionada(resposta),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
