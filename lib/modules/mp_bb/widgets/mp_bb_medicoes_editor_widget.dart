import 'package:flutter/material.dart';
import 'package:sympla_app/core/domain/dto/mpbb/medicao_elemento_table_dto.dart';

class MedicoesEditor extends StatefulWidget {
  final List<MedicaoElementoBateriaDto> medicoes;
  final void Function(List<MedicaoElementoBateriaDto>) onChanged;

  const MedicoesEditor({
    super.key,
    required this.medicoes,
    required this.onChanged,
  });

  @override
  State<MedicoesEditor> createState() => _MedicoesEditorState();
}

class _MedicoesEditorState extends State<MedicoesEditor> {
  late List<MedicaoElementoBateriaDto> _lista;

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
      _lista.add(MedicaoElementoBateriaDto(
        id: 0,
        formularioBateriaId: 0,
        elementoBateriaNumero: novoNumero,
        tensao: null,
        resistenciaInterna: null,
      ));
    });
    widget.onChanged(List.from(_lista));
  }

  void _atualizarTensao(int index, String valor) {
    // final parsed = double.tryParse(valor);
    // _lista[index].tensao.value = parsed;
    widget.onChanged(List.from(_lista));
  }

  void _atualizarResistencia(int index, String valor) {
    // final parsed = double.tryParse(valor);
    // _lista[index].resistenciaInterna = parsed;
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
              children: [
                Text('Elemento ${_lista[i].elementoBateriaNumero}'),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    initialValue: _lista[i].tensao?.toString() ?? '',
                    decoration: const InputDecoration(labelText: 'Tensão (V)'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) => _atualizarTensao(i, value),
                  ),
                ),
                const SizedBox(width: 12),
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
