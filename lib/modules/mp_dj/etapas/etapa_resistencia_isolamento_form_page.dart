import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/posicao_disjuntor_ensaio_converter.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';
import 'package:drift/drift.dart' as d;

class EtapaResistenciaIsolamentoPage extends StatefulWidget {
  const EtapaResistenciaIsolamentoPage({super.key});

  @override
  State<EtapaResistenciaIsolamentoPage> createState() =>
      _EtapaResistenciaIsolamentoPageState();
}

class _EtapaResistenciaIsolamentoPageState
    extends State<EtapaResistenciaIsolamentoPage> {
  final controller = Get.find<MpDjFormController>();
  final List<_MedicaoFields> _medicoes = [];

  final _dropdownValues = PosicaoDisjuntorEnsaio.values;

  @override
  void initState() {
    super.initState();
    _adicionarMedicao();
  }

  void _adicionarMedicao() {
    setState(() {
      _medicoes.add(_MedicaoFields(numero: _medicoes.length + 1));
    });
  }

  void _salvar() {
    final id = controller.formulario.value?.id;
    if (id == null) {
      Get.snackbar('Erro', 'Formulário não encontrado');
      return;
    }

    final dados = _medicoes.map((m) {
      return MedicaoResistenciaIsolamentoTableCompanion(
        formularioDisjuntorId: d.Value(id),
        linha: d.Value(m.linha),
        terra: d.Value(m.terra),
        guarda: d.Value(m.guarda),
        tensaoKv: d.Value(double.tryParse(m.tensao.text.trim()) ?? 0.0),
        resistenciaFaseA: d.Value(double.tryParse(m.resA.text.trim()) ?? 0.0),
        resistenciaFaseB: d.Value(double.tryParse(m.resB.text.trim()) ?? 0.0),
        resistenciaFaseC: d.Value(double.tryParse(m.resC.text.trim()) ?? 0.0),
        temperaturaDisjuntor:
            d.Value(double.tryParse(m.temp.text.trim()) ?? 0.0),
        umidadeRelativaAr:
            d.Value(double.tryParse(m.umidade.text.trim()) ?? 0.0),
      );
    }).toList();

    controller.salvarIsolamentos(dados);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resistência de Isolamento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _salvar,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for (var m in _medicoes)
              _MedicaoWidget(medicao: m, dropdownValues: _dropdownValues),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _adicionarMedicao,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Medição'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicaoFields {
  final int numero;
  PosicaoDisjuntorEnsaio linha = PosicaoDisjuntorEnsaio.entrada;
  PosicaoDisjuntorEnsaio terra = PosicaoDisjuntorEnsaio.saida;
  PosicaoDisjuntorEnsaio guarda = PosicaoDisjuntorEnsaio.terra;

  final TextEditingController tensao = TextEditingController();
  final TextEditingController resA = TextEditingController();
  final TextEditingController resB = TextEditingController();
  final TextEditingController resC = TextEditingController();
  final TextEditingController temp = TextEditingController();
  final TextEditingController umidade = TextEditingController();

  _MedicaoFields({required this.numero});
}

class _MedicaoWidget extends StatelessWidget {
  final _MedicaoFields medicao;
  final List<PosicaoDisjuntorEnsaio> dropdownValues;

  const _MedicaoWidget({
    required this.medicao,
    required this.dropdownValues,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text('Medição ${medicao.numero}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<PosicaoDisjuntorEnsaio>(
                    value: medicao.linha,
                    decoration: const InputDecoration(labelText: 'Linha'),
                    items: dropdownValues
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.name.toUpperCase())))
                        .toList(),
                    onChanged: (v) => medicao.linha = v!,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<PosicaoDisjuntorEnsaio>(
                    value: medicao.terra,
                    decoration: const InputDecoration(labelText: 'Terra'),
                    items: dropdownValues
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.name.toUpperCase())))
                        .toList(),
                    onChanged: (v) => medicao.terra = v!,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<PosicaoDisjuntorEnsaio>(
                    value: medicao.guarda,
                    decoration: const InputDecoration(labelText: 'Guarda'),
                    items: dropdownValues
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.name.toUpperCase())))
                        .toList(),
                    onChanged: (v) => medicao.guarda = v!,
                  ),
                ),
              ],
            ),
            TextField(
              controller: medicao.tensao,
              decoration: const InputDecoration(labelText: 'Tensão KV'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: medicao.resA,
              decoration:
                  const InputDecoration(labelText: 'Resistência Fase A (MΩ)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: medicao.resB,
              decoration:
                  const InputDecoration(labelText: 'Resistência Fase B (MΩ)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: medicao.resC,
              decoration:
                  const InputDecoration(labelText: 'Resistência Fase C (MΩ)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: medicao.temp,
              decoration: const InputDecoration(
                  labelText: 'Temperatura Disjuntor (°C)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: medicao.umidade,
              decoration:
                  const InputDecoration(labelText: 'Umidade Relativa (%)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
