import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_contato_table_dto.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';

class EtapaResistenciaContatoPage extends StatefulWidget {
  const EtapaResistenciaContatoPage({super.key});

  @override
  State<EtapaResistenciaContatoPage> createState() =>
      _EtapaResistenciaContatoPageState();
}

class _EtapaResistenciaContatoPageState
    extends State<EtapaResistenciaContatoPage> {
  final controller = Get.find<MpDjFormController>();

  final List<_CamaraControllers> camaras = [];

  @override
  void initState() {
    super.initState();
    _preencherCamposSeExistir();
  }

  void _preencherCamposSeExistir() {
    final lista = controller.resistenciasContato;
    if (lista.isNotEmpty) {
      for (final med in lista) {
        final c = _CamaraControllers(numero: med.numeroCamara);
        c.faseA.text = med.resistenciaFaseA?.toString() ?? '';
        c.faseB.text = med.resistenciaFaseB?.toString() ?? '';
        c.faseC.text = med.resistenciaFaseC?.toString() ?? '';
        c.temp.text = med.temperaturaDisjuntor?.toString() ?? '';
        c.umidade.text = med.umidadeRelativaAr?.toString() ?? '';
        camaras.add(c);
      }
    } else {
      camaras.add(_CamaraControllers(numero: 1));
    }
  }

  @override
  void dispose() {
    for (var c in camaras) {
      c.dispose();
    }
    super.dispose();
  }

  void _adicionarCamara() {
    setState(() {
      final proximoNumero = camaras.isEmpty
          ? 1
          : camaras.map((e) => e.numero).reduce((a, b) => a > b ? a : b) + 1;
      camaras.add(_CamaraControllers(numero: proximoNumero));
    });
  }

  void _removerCamara(int index) {
    setState(() {
      camaras.removeAt(index);
    });
  }

  void _salvar() {
    final id = controller.formulario.value?.id;
    if (id == null) {
      Get.snackbar('Erro', 'Formulário não encontrado');
      return;
    }

    final dados = camaras.map((c) {
      return MedicaoResistenciaContatoTableDto(
        id: 0,
        formularioDisjuntorId: id,
        numeroCamara: c.numero,
        resistenciaFaseA: double.tryParse(c.faseA.text.trim()),
        resistenciaFaseB: double.tryParse(c.faseB.text.trim()),
        resistenciaFaseC: double.tryParse(c.faseC.text.trim()),
        temperaturaDisjuntor: double.tryParse(c.temp.text.trim()),
        umidadeRelativaAr: double.tryParse(c.umidade.text.trim()),
      );
    }).toList();

    controller.salvarResistenciasContato(dados);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resistência de Contato'),
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
              ...camaras.asMap().entries.map((entry) {
                final index = entry.key;
                final c = entry.value;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Câmara ${c.numero}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        TextField(
                          controller: c.faseA,
                          decoration:
                              const InputDecoration(labelText: 'Fase A (μΩ)'),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                        TextField(
                          controller: c.faseB,
                          decoration:
                              const InputDecoration(labelText: 'Fase B (μΩ)'),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                        TextField(
                          controller: c.faseC,
                          decoration:
                              const InputDecoration(labelText: 'Fase C (μΩ)'),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                        TextField(
                          controller: c.temp,
                          decoration: const InputDecoration(
                              labelText: 'Temperatura Disjuntor (°C)'),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                        TextField(
                          controller: c.umidade,
                          decoration: const InputDecoration(
                              labelText: 'Umidade Relativa do Ar (%)'),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                        if (camaras.length > 1)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => _removerCamara(index),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text('Remover',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
              ElevatedButton.icon(
                onPressed: _adicionarCamara,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Câmara'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _CamaraControllers {
  final int numero;
  final TextEditingController faseA = TextEditingController();
  final TextEditingController faseB = TextEditingController();
  final TextEditingController faseC = TextEditingController();
  final TextEditingController temp = TextEditingController();
  final TextEditingController umidade = TextEditingController();

  _CamaraControllers({required this.numero});

  void dispose() {
    faseA.dispose();
    faseB.dispose();
    faseC.dispose();
    temp.dispose();
    umidade.dispose();
  }
}
