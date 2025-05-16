import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_tempo_operacao_table_dto.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';

class EtapaTempoOperacaoPage extends StatefulWidget {
  const EtapaTempoOperacaoPage({super.key});

  @override
  State<EtapaTempoOperacaoPage> createState() => _EtapaTempoOperacaoPageState();
}

class _EtapaTempoOperacaoPageState extends State<EtapaTempoOperacaoPage> {
  final controller = Get.find<MpDjFormController>();

  final Map<FaseAnomalia, Map<String, TextEditingController>> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (final fase in FaseAnomalia.values) {
      _controllers[fase] = {
        'fechamento': TextEditingController(),
        'aberturaBobina1': TextEditingController(),
        'aberturaBobina2': TextEditingController(),
        'fechamentoTripFree': TextEditingController(),
        'aberturaTripFreeBob1': TextEditingController(),
        'aberturaTripFreeBob2': TextEditingController(),
        'curtoBob1': TextEditingController(),
        'curtoBob2': TextEditingController(),
        'dadoPlacaFechamento': TextEditingController(),
        'dadoPlacaAbertura': TextEditingController(),
      };
    }
  }

  @override
  void dispose() {
    for (final mapa in _controllers.values) {
      for (final c in mapa.values) {
        c.dispose();
      }
    }
    super.dispose();
  }

  void _salvar() {
    final id = controller.formulario.value?.id;
    if (id == null) {
      Get.snackbar('Erro', 'Formulário não encontrado');
      return;
    }

    final dados = FaseAnomalia.values.map((fase) {
      final c = _controllers[fase]!;

      return MedicaoTempoOperacaoTableDto(
        id: 0,
        formularioDisjuntorId: id,
        fase: fase.name,
        fechamentoBobina1: double.tryParse(c['fechamento']!.text.trim()) ?? 0.0,
        aberturaBobina1:
            double.tryParse(c['aberturaBobina1']!.text.trim()) ?? 0.0,
        aberturaBobina2:
            double.tryParse(c['aberturaBobina2']!.text.trim()) ?? 0.0,
        fechamentoBobina2: double.tryParse(c['fechamento']!.text.trim()) ?? 0.0,
      );
    }).toList();

    controller.salvarTempos(dados);
  }

  Widget _buildFaseForm(FaseAnomalia fase) {
    final c = _controllers[fase]!;
    final label = 'Fase ${fase.name.toUpperCase()}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: c['fechamento'],
          decoration: const InputDecoration(labelText: 'Fechamento (ms)'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: c['aberturaBobina1'],
          decoration:
              const InputDecoration(labelText: 'Abertura Bobina 1 (ms)'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: c['aberturaBobina2'],
          decoration:
              const InputDecoration(labelText: 'Abertura Bobina 2 (ms)'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        const Text('Trip Free'),
        TextField(
          controller: c['fechamentoTripFree'],
          decoration:
              const InputDecoration(labelText: 'Fechamento Trip Free (ms)'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: c['aberturaTripFreeBob1'],
          decoration: const InputDecoration(
              labelText: 'Abertura Trip Free Bobina 1 (ms)'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: c['aberturaTripFreeBob2'],
          decoration: const InputDecoration(
              labelText: 'Abertura Trip Free Bobina 2 (ms)'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        const Text('Curto-Circuito'),
        TextField(
          controller: c['curtoBob1'],
          decoration: const InputDecoration(labelText: 'Curto Bobina 1 (ms)'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: c['curtoBob2'],
          decoration: const InputDecoration(labelText: 'Curto Bobina 2 (ms)'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        const Text('Dados de Placa'),
        TextField(
          controller: c['dadoPlacaFechamento'],
          decoration: const InputDecoration(labelText: 'Fechamento (ms)'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: c['dadoPlacaAbertura'],
          decoration: const InputDecoration(labelText: 'Abertura (ms)'),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tempo de Operação'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _salvar,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: FaseAnomalia.values.map(_buildFaseForm).toList(),
        ),
      ),
    );
  }
}
