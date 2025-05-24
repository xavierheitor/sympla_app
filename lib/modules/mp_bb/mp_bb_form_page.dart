import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/storage/converters/tipo_bateria_converter.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_controller.dart';
import 'package:sympla_app/modules/mp_bb/widgets/mp_bb_medicoes_editor_widget.dart';
import 'package:sympla_app/core/domain/dto/mpbb/formulario_bateria_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpbb/medicao_elemento_table_dto.dart';

double? parseDouble(String input) {
  return double.tryParse(input.trim().replaceAll(',', '.'));
}

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

  final _medicoesTemp = <MedicaoElementoMpbbTableDto>[].obs;

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
                final dados = FormularioBateriaTableDto(
                  id: controller.formulario.value?.id,
                  atividadeId: controller
                      .atividadeController.atividadeEmAndamento.value!.uuid,
                  fabricante: _fabricanteController.text,
                  modelo: _modeloController.text,
                  capacidadeAh: int.tryParse(_capacidadeController.text.trim()),
                  tensaoFlutuacaoCelula:
                      parseDouble(_tensaoCelulaController.text),
                  tensaoFlutuacaoBanco:
                      parseDouble(_tensaoBancoController.text),
                  rippleMedido: parseDouble(_rippleController.text),
                  tipoBateria:
                      controller.formulario.value?.tipoBateria ??
                      TipoBateria.ventilada.name,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  densidadeCritica: null,
                  densidadeNominal: null,
                  resistenciaNominal: null,
                );

                controller.salvarFormulario(
                  dados: dados,
                  medicoesList: _medicoesTemp.toList(),
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
                    _medicoesTemp.assignAll(novas);
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
