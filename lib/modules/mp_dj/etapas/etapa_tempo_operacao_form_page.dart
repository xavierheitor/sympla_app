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
    _inicializarCampos();
  }

  void _inicializarCampos() {
    for (final fase in FaseAnomalia.values) {
      _controllers[fase] = {
        'fechamentoBobina1': TextEditingController(),
        'fechamentoBobina2': TextEditingController(),
        'aberturaBobina1': TextEditingController(),
        'aberturaBobina2': TextEditingController(),
      };
    }

    // Carregar se houver dados salvos
    final dados = controller.tempos;
    if (dados.isNotEmpty) {
      for (final med in dados) {
        final fase = FaseAnomalia.values.firstWhere((e) => e.name == med.fase,
            orElse: () => FaseAnomalia.a);
        final c = _controllers[fase]!;

        c['fechamentoBobina1']!.text = med.fechamentoBobina1?.toString() ?? '';
        c['fechamentoBobina2']!.text = med.fechamentoBobina2?.toString() ?? '';
        c['aberturaBobina1']!.text = med.aberturaBobina1?.toString() ?? '';
        c['aberturaBobina2']!.text = med.aberturaBobina2?.toString() ?? '';
      }
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
        formularioDisjuntorId: id,
        fase: fase.name,
        fechamentoBobina1: double.tryParse(c['fechamentoBobina1']!.text.trim()),
        fechamentoBobina2: double.tryParse(c['fechamentoBobina2']!.text.trim()),
        aberturaBobina1: double.tryParse(c['aberturaBobina1']!.text.trim()),
        aberturaBobina2: double.tryParse(c['aberturaBobina2']!.text.trim()),
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
        _campo(c['fechamentoBobina1']!, 'Fechamento Bobina 1 (ms)'),
        _campo(c['fechamentoBobina2']!, 'Fechamento Bobina 2 (ms)'),
        _campo(c['aberturaBobina1']!, 'Abertura Bobina 1 (ms)'),
        _campo(c['aberturaBobina2']!, 'Abertura Bobina 2 (ms)'),
      ],
    );
  }

  Widget _campo(TextEditingController c, String label) {
    return TextField(
      controller: c,
      decoration: InputDecoration(labelText: label),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
      body: Obx(() {
        if (controller.carregando.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: FaseAnomalia.values.map(_buildFaseForm).toList(),
          ),
        );
      }),
    );
  }
}
