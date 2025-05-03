import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';
import 'package:drift/drift.dart' as d;

class EtapaResistenciaContatoPage extends StatefulWidget {
  const EtapaResistenciaContatoPage({super.key});

  @override
  State<EtapaResistenciaContatoPage> createState() =>
      _EtapaResistenciaContatoPageState();
}

class _EtapaResistenciaContatoPageState
    extends State<EtapaResistenciaContatoPage> {
  final controller = Get.find<MpDjFormController>();

  final List<_CamaraControllers> camaras = [
    _CamaraControllers(numero: 1),
  ];

  @override
  void dispose() {
    for (var c in camaras) {
      c.dispose();
    }
    super.dispose();
  }

  void _adicionarCamara() {
    setState(() {
      camaras.add(_CamaraControllers(numero: camaras.length + 1));
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
      return MedicaoResistenciaContatoTableCompanion(
        formularioDisjuntorId: d.Value(id),
        numeroCamara: d.Value(c.numero),
        resistenciaFaseA: d.Value(double.tryParse(c.faseA.text.trim()) ?? 0.0),
        resistenciaFaseB: d.Value(double.tryParse(c.faseB.text.trim()) ?? 0.0),
        resistenciaFaseC: d.Value(double.tryParse(c.faseC.text.trim()) ?? 0.0),
        temperaturaDisjuntor:
            d.Value(double.tryParse(c.temp.text.trim()) ?? 0.0),
        umidadeRelativaAr:
            d.Value(double.tryParse(c.umidade.text.trim()) ?? 0.0),
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
      body: SingleChildScrollView(
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
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: c.faseB,
                        decoration:
                            const InputDecoration(labelText: 'Fase B (μΩ)'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: c.faseC,
                        decoration:
                            const InputDecoration(labelText: 'Fase C (μΩ)'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: c.temp,
                        decoration: const InputDecoration(
                            labelText: 'Temperatura Disjuntor (°C)'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: c.umidade,
                        decoration: const InputDecoration(
                            labelText: 'Umidade Relativa do Ar (%)'),
                        keyboardType: TextInputType.number,
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
            }).toList(),
            ElevatedButton.icon(
              onPressed: _adicionarCamara,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Câmara'),
            ),
          ],
        ),
      ),
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
