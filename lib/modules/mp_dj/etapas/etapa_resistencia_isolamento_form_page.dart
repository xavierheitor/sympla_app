import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_isolamento_table_dto.dart';
import 'package:sympla_app/core/storage/converters/posicao_disjuntor_ensaio_converter.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';

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
    _preencherCamposSeExistir();
  }

  void _preencherCamposSeExistir() {
    final lista = controller.isolamentos;
    if (lista.isNotEmpty) {
      for (final med in lista) {
        final m = _MedicaoFields(numero: med.formularioDisjuntorId);
        m.linha = PosicaoDisjuntorEnsaio.values.firstWhere(
            (e) => e.name == med.linha,
            orElse: () => PosicaoDisjuntorEnsaio.entrada);
        m.terra = PosicaoDisjuntorEnsaio.values.firstWhere(
            (e) => e.name == med.terra,
            orElse: () => PosicaoDisjuntorEnsaio.saida);
        m.guarda = PosicaoDisjuntorEnsaio.values.firstWhere(
            (e) => e.name == med.guarda,
            orElse: () => PosicaoDisjuntorEnsaio.terra);
        m.tensao.text = med.tensaoKv.toString();
        m.resA.text = med.resistenciaFaseA?.toString() ?? '';
        m.resB.text = med.resistenciaFaseB?.toString() ?? '';
        m.resC.text = med.resistenciaFaseC?.toString() ?? '';
        m.temp.text = med.temperaturaDisjuntor?.toString() ?? '';
        m.umidade.text = med.umidadeRelativaAr?.toString() ?? '';
        _medicoes.add(m);
      }
    } else {
      _adicionarMedicao();
    }
  }

  void _adicionarMedicao() {
    setState(() {
      final proximoNumero = _medicoes.isEmpty
          ? 1
          : _medicoes.map((e) => e.numero).reduce((a, b) => a > b ? a : b) + 1;
      _medicoes.add(_MedicaoFields(numero: proximoNumero));
    });
  }

  void _removerMedicao(int index) {
    setState(() {
      _medicoes.removeAt(index);
    });
  }

  void _salvar() {
    final id = controller.formulario.value?.id;
    if (id == null) {
      Get.snackbar('Erro', 'Formulário não encontrado');
      return;
    }

    final dados = _medicoes.map((m) {
      return MedicaoResistenciaIsolamentoTableDto(
        id: 0,
        formularioDisjuntorId: id,
        linha: m.linha.name,
        terra: m.terra.name,
        guarda: m.guarda.name,
        tensaoKv: double.tryParse(m.tensao.text.trim()) ?? 0.0,
        resistenciaFaseA: double.tryParse(m.resA.text.trim()),
        resistenciaFaseB: double.tryParse(m.resB.text.trim()),
        resistenciaFaseC: double.tryParse(m.resC.text.trim()),
        temperaturaDisjuntor: double.tryParse(m.temp.text.trim()),
        umidadeRelativaAr: double.tryParse(m.umidade.text.trim()),
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
      body: Obx(() {
        if (controller.carregando.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ..._medicoes.asMap().entries.map((entry) {
                final index = entry.key;
                final m = entry.value;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Medição ${m.numero}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const Spacer(),
                            if (_medicoes.length > 1)
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removerMedicao(index),
                              )
                          ],
                        ),
                        Row(
                          children: [
                            _dropdown('Linha', m.linha,
                                (v) => setState(() => m.linha = v!)),
                            const SizedBox(width: 8),
                            _dropdown('Terra', m.terra,
                                (v) => setState(() => m.terra = v!)),
                            const SizedBox(width: 8),
                            _dropdown('Guarda', m.guarda,
                                (v) => setState(() => m.guarda = v!)),
                          ],
                        ),
                        _textField(m.tensao, 'Tensão KV'),
                        _textField(m.resA, 'Resistência Fase A (MΩ)'),
                        _textField(m.resB, 'Resistência Fase B (MΩ)'),
                        _textField(m.resC, 'Resistência Fase C (MΩ)'),
                        _textField(m.temp, 'Temperatura Disjuntor (°C)'),
                        _textField(m.umidade, 'Umidade Relativa (%)'),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _adicionarMedicao,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Medição'),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _dropdown(String label, PosicaoDisjuntorEnsaio valorSelecionado,
      ValueChanged<PosicaoDisjuntorEnsaio?> onChanged) {
    return Expanded(
      child: DropdownButtonFormField<PosicaoDisjuntorEnsaio>(
        value: valorSelecionado,
        decoration: InputDecoration(labelText: label),
        items: _dropdownValues
            .map((e) =>
                DropdownMenuItem(value: e, child: Text(e.name.toUpperCase())))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _textField(TextEditingController c, String label) {
    return TextField(
      controller: c,
      decoration: InputDecoration(labelText: label),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
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

  void dispose() {
    tensao.dispose();
    resA.dispose();
    resB.dispose();
    resC.dispose();
    temp.dispose();
    umidade.dispose();
  }
}
