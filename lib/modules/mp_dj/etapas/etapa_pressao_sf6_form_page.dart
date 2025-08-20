import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_pressao_sf6_table_dto.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';

class EtapaPressaoSf6Page extends StatefulWidget {
  const EtapaPressaoSf6Page({super.key});

  @override
  State<EtapaPressaoSf6Page> createState() => _EtapaPressaoSf6PageState();
}

class _EtapaPressaoSf6PageState extends State<EtapaPressaoSf6Page> {
  final controller = Get.find<MpDjFormController>();

  final Map<FaseAnomalia, TextEditingController> _pressaoControllers = {};
  final Map<FaseAnomalia, TextEditingController> _temperaturaControllers = {};

  @override
  void initState() {
    super.initState();
    for (final fase in FaseAnomalia.values) {
      _pressaoControllers[fase] = TextEditingController();
      _temperaturaControllers[fase] = TextEditingController();
    }

    _preencherCamposSeExistir();
  }

  void _preencherCamposSeExistir() {
    final lista = controller.pressoes;
    if (lista.isNotEmpty) {
      for (final med in lista) {
        final fase = FaseAnomalia.values.firstWhereOrNull(
          (f) => f.name == med.fase,
        );
        if (fase != null) {
          _pressaoControllers[fase]?.text = med.valorPressao.toString();
          _temperaturaControllers[fase]?.text = med.temperatura.toString();
        }
      }
    }
  }

  @override
  void dispose() {
    for (final c in _pressaoControllers.values) {
      c.dispose();
    }
    for (final c in _temperaturaControllers.values) {
      c.dispose();
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
      return MedicaoPressaoSf6TableDto(
        id: 0,
        formularioDisjuntorId: id,
        fase: fase.name,
        valorPressao:
            double.tryParse(_pressaoControllers[fase]?.text.trim() ?? '') ??
                0.0,
        temperatura:
            double.tryParse(_temperaturaControllers[fase]?.text.trim() ?? '') ??
                0.0,
      );
    }).toList();

    controller.salvarPressaoSf6(dados);
  }

  Widget _buildFaseInput(FaseAnomalia fase) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Text(
          'Fase ${fase.name.toUpperCase()}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _pressaoControllers[fase],
          decoration: const InputDecoration(labelText: 'Pressão (bar)'),
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: false),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _temperaturaControllers[fase],
          decoration: const InputDecoration(labelText: 'Temperatura (°C)'),
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: false),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pressão SF6'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: Get.back,
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
            children: FaseAnomalia.values.map(_buildFaseInput).toList(),
          ),
        );
      }),
    );
  }
}
