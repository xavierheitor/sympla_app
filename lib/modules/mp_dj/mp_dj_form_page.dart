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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Instrumentos de Medição',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CampoTexto(
                  label: 'Termohigrômetro - Fabricante',
                  controller: controller.termohigrometroFabricante),
              CampoTexto(
                  label: 'Termohigrômetro - Tipo',
                  controller: controller.termohigrometroTipo),
              CampoData(
                  label: 'Termohigrômetro - Última Calibração',
                  controller: controller.termohigrometroData),
              const SizedBox(height: 16),
              CampoTexto(
                  label: 'Micromímetro - Fabricante',
                  controller: controller.micromimetroFabricante),
              CampoTexto(
                  label: 'Micromímetro - Tipo',
                  controller: controller.micromimetroTipo),
              CampoData(
                  label: 'Micromímetro - Última Calibração',
                  controller: controller.micromimetroData),
              const SizedBox(height: 16),
              CampoTexto(
                  label: 'Megômetro - Fabricante',
                  controller: controller.megometroFabricante),
              CampoTexto(
                  label: 'Megômetro - Tipo',
                  controller: controller.megometroTipo),
              CampoData(
                  label: 'Megômetro - Última Calibração',
                  controller: controller.megometroData),
              const SizedBox(height: 16),
              CampoTexto(
                  label: 'Oscilógrafo - Fabricante',
                  controller: controller.oscilografoFabricante),
              CampoTexto(
                  label: 'Oscilógrafo - Tipo',
                  controller: controller.oscilografoTipo),
              CampoData(
                  label: 'Oscilógrafo - Última Calibração',
                  controller: controller.oscilografoData),
              const SizedBox(height: 24),
              const Text('Dados do Disjuntor',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CampoTexto(
                  label: 'Fabricante',
                  controller: controller.disjuntorFabricante),
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
            ],
          ),
        );
      }),
    );
  }
}
