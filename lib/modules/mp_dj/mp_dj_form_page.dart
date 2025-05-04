import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';
import 'package:sympla_app/modules/mp_dj/widgets/campo_data.dart';
import 'package:sympla_app/modules/mp_dj/widgets/campo_texto.dart';

class MpDjFormPage extends StatefulWidget {
  const MpDjFormPage({super.key});

  @override
  State<MpDjFormPage> createState() => _MpDjFormPageState();
}

class _MpDjFormPageState extends State<MpDjFormPage> {
  late MpDjFormController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<MpDjFormController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados Iniciais - MPDJ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: controller.salvarEDirecionar,
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
              _buildInstrumentoSection(
                'Termohigrômetro',
                [
                  CampoTexto(
                      label: 'Fabricante',
                      controller: controller.termohigrometroFabricante),
                  CampoTexto(
                      label: 'Tipo',
                      controller: controller.termohigrometroTipo),
                  CampoData(
                      label: 'Última Calibração',
                      controller: controller.termohigrometroData),
                ],
              ),
              _buildInstrumentoSection(
                'Micromímetro',
                [
                  CampoTexto(
                      label: 'Fabricante',
                      controller: controller.micromimetroFabricante),
                  CampoTexto(
                      label: 'Tipo', controller: controller.micromimetroTipo),
                  CampoData(
                      label: 'Última Calibração',
                      controller: controller.micromimetroData),
                ],
              ),
              _buildInstrumentoSection(
                'Megômetro',
                [
                  CampoTexto(
                      label: 'Fabricante',
                      controller: controller.megometroFabricante),
                  CampoTexto(
                      label: 'Tipo', controller: controller.megometroTipo),
                  CampoData(
                      label: 'Última Calibração',
                      controller: controller.megometroData),
                ],
              ),
              _buildInstrumentoSection(
                'Oscilógrafo',
                [
                  CampoTexto(
                      label: 'Fabricante',
                      controller: controller.oscilografoFabricante),
                  CampoTexto(
                      label: 'Tipo', controller: controller.oscilografoTipo),
                  CampoData(
                      label: 'Última Calibração',
                      controller: controller.oscilografoData),
                ],
              ),
              const SizedBox(height: 24),
              _buildDisjuntorSection(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInstrumentoSection(String titulo, List<Widget> campos) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(titulo,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black)),
        children: campos
            .map((campo) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: campo,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildDisjuntorSection() {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: const Text(
          'Dados do Disjuntor',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        children: [
          CampoTexto(
              label: 'Fabricante', controller: controller.disjuntorFabricante),
          CampoTexto(
              label: 'Ano de Fabricação',
              controller: controller.disjuntorAnoFabricacao),
          CampoTexto(
              label: 'Tensão Nominal (kV)',
              controller: controller.disjuntorTensaoNominal),
          CampoTexto(
              label: 'Corrente Nominal (A)',
              controller: controller.disjuntorCorrenteNominal),
          CampoTexto(
              label: 'Capacidade de Interrupção (kA)',
              controller: controller.disjuntorCapInterrupcaoNominal),
          CampoTexto(
              label: 'Tipo de Extinção',
              controller: controller.disjuntorTipoExtinsao),
          CampoTexto(
              label: 'Tipo de Acionamento',
              controller: controller.disjuntorTipoAcionamento),
          CampoTexto(
              label: 'Pressão SF6 Nominal (bar)',
              controller: controller.disjuntorPressaoSf6Nominal),
          CampoTexto(
              label: 'Temperatura Nominal SF6 (°C)',
              controller: controller.disjuntorPressaoSf6NominalTemperatura),
        ]
            .map((campo) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: campo,
                ))
            .toList(),
      ),
    );
  }
}
