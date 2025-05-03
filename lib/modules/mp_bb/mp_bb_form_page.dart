import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/data/models/medicao_temp.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/tipo_bateria_converter.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_controller.dart';
import 'package:sympla_app/modules/mp_bb/widgets/mp_bb_medicoes_editor_widget.dart';

class MpBbFormPage extends StatefulWidget {
  const MpBbFormPage({super.key});

  @override
  State<MpBbFormPage> createState() => _MpBbFormPageState();
}

class _MpBbFormPageState extends State<MpBbFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _fabricanteController = TextEditingController();
  final _modeloController = TextEditingController();
  final _capacidadeController = TextEditingController();
  final _tensaoCelulaController = TextEditingController();
  final _tensaoBancoController = TextEditingController();
  final _rippleController = TextEditingController();

  List<MedicaoTemp> _medicoesTemp = [];

  @override
  void dispose() {
    _fabricanteController.dispose();
    _modeloController.dispose();
    _capacidadeController.dispose();
    _tensaoCelulaController.dispose();
    _tensaoBancoController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MpBbFormController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário BCBAT'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed(Routes.home);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                final dados = FormularioBateriaTableCompanion(
                  atividadeId: drift.Value(controller.atividadeId),
                  fabricante: drift.Value(_fabricanteController.text),
                  modelo: drift.Value(_modeloController.text),
                  capacidadeAh: drift.Value(
                      int.tryParse(_capacidadeController.text) ?? 0),
                  tensaoFlutuacaoCelula: drift.Value(
                      double.tryParse(_tensaoCelulaController.text.trim()) ??
                          0.0),
                  tensaoFlutuacaoBanco: drift.Value(
                      double.tryParse(_tensaoBancoController.text.trim()) ??
                          0.0),
                  rippleMedido: drift.Value(
                      double.tryParse(_rippleController.text.trim()) ?? 0.0),
                  tipoBateria: drift.Value(
                      controller.formulario.value?.tipoBateria ??
                          TipoBateria.ventilada),
                );

                final medicoesList = _medicoesTemp
                    .map((m) => MedicaoElementoBateriaTableCompanion(
                          elementoBateriaNumero: drift.Value(m.numero),
                          tensao: drift.Value(m.tensao.value),
                          resistenciaInterna: drift.Value(m.resistencia.value),
                        ))
                    .toList();

                controller.salvarFormulario(
                  dados: dados,
                  medicoesList: medicoesList,
                );
              }
            },
          )
        ],
      ),
      body: Obx(() {
        if (controller.carregando.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final form = controller.formulario.value;
        if (form != null) {
          _fabricanteController.text = form.fabricante ?? '';
          _modeloController.text = form.modelo ?? '';
          _capacidadeController.text = form.capacidadeAh?.toString() ?? '';
          _tensaoCelulaController.text =
              form.tensaoFlutuacaoCelula?.toString() ?? '';
          _tensaoBancoController.text =
              form.tensaoFlutuacaoBanco?.toString() ?? '';
          _rippleController.text = form.rippleMedido?.toString() ?? '';
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _fabricanteController,
                  decoration: const InputDecoration(labelText: 'Fabricante'),
                ),
                TextFormField(
                  controller: _modeloController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                ),
                TextFormField(
                  controller: _capacidadeController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Capacidade (Ah)'),
                ),
                TextFormField(
                  controller: _tensaoCelulaController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      labelText: 'Tensão flutuação célula (V)'),
                ),
                TextFormField(
                  controller: _tensaoBancoController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      labelText: 'Tensão flutuação banco (V)'),
                ),
                TextFormField(
                  controller: _rippleController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      const InputDecoration(labelText: 'Ripple Medido (mV)'),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Medições por elemento:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                MedicoesEditor(
                  medicoes: _medicoesTemp,
                  onChanged: (novas) {
                    _medicoesTemp = novas;
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
