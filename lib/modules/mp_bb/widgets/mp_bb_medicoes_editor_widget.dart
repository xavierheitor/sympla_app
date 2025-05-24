import 'package:flutter/material.dart';
import 'package:sympla_app/core/domain/dto/mpbb/medicao_elemento_table_dto.dart';

double? parseDouble(String input) {
  return double.tryParse(input.trim().replaceAll(',', '.'));
}

class MedicoesEditor extends StatefulWidget {
  final List<MedicaoElementoMpbbTableDto> medicoes;
  final void Function(List<MedicaoElementoMpbbTableDto>) onChanged;

  const MedicoesEditor({
    super.key,
    required this.medicoes,
    required this.onChanged,
  });

  @override
  State<MedicoesEditor> createState() => _MedicoesEditorState();
}

class _MedicoesEditorState extends State<MedicoesEditor> {
  late List<MedicaoElementoMpbbTableDto> _lista;

  @override
  void initState() {
    super.initState();
    _lista = List.from(widget.medicoes);
  }

  void _adicionarMedicao() {
    final novoNumero = _lista.isNotEmpty
        ? _lista
                .map((e) => e.elementoBateriaNumero)
                .reduce((a, b) => a > b ? a : b) +
            1
        : 1;

    setState(() {
      _lista.add(MedicaoElementoMpbbTableDto(
        formularioBateriaId: 0, // Será preenchido no salvamento correto
        elementoBateriaNumero: novoNumero,
        tensao: null,
        resistenciaInterna: null,
      ));
    });

    widget.onChanged(List.from(_lista));
  }

  void _atualizarTensao(int index, String valor) {
    final parsed = parseDouble(valor);
    setState(() {
      _lista[index] = _lista[index].copyWith(tensao: parsed);
    });
    widget.onChanged(List.from(_lista));
  }

  void _atualizarResistencia(int index, String valor) {
    final parsed = parseDouble(valor);
    setState(() {
      _lista[index] = _lista[index].copyWith(resistenciaInterna: parsed);
    });
    widget.onChanged(List.from(_lista));
  }

  void _removerMedicao(int index) {
    setState(() {
      _lista.removeAt(index);
    });
    widget.onChanged(List.from(_lista));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < _lista.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Elemento ${_lista[i].elementoBateriaNumero}'),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    initialValue: _lista[i].tensao?.toString() ?? '',
                    decoration: const InputDecoration(labelText: 'Tensão (V)'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) => _atualizarTensao(i, value),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    initialValue:
                        _lista[i].resistenciaInterna?.toString() ?? '',
                    decoration:
                        const InputDecoration(labelText: 'Resistência (mΩ)'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) => _atualizarResistencia(i, value),
                  ),
                ),
                IconButton(
                  onPressed: () => _removerMedicao(i),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: _adicionarMedicao,
          icon: const Icon(Icons.add),
          label: const Text('Adicionar Medição'),
        ),
      ],
    );
  }
}
