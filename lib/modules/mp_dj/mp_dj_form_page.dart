import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/storage/converters/caracterizacao_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_extinsao_disjutnor_converter.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';
import 'package:sympla_app/modules/mp_dj/widgets/campo_data.dart';
import 'package:sympla_app/modules/mp_dj/widgets/campo_select.dart';
import 'package:sympla_app/modules/mp_dj/widgets/campo_texto.dart';

class MpDjFormPage extends StatefulWidget {
  const MpDjFormPage({super.key});

  @override
  State<MpDjFormPage> createState() => _MpDjFormPageState();
}

class _MpDjFormPageState extends State<MpDjFormPage> {
  late MpDjFormController controller;

  // Instrumentos
  final termohigrometroFabricante = TextEditingController();
  final termohigrometroTipo = TextEditingController();
  final termohigrometroData = TextEditingController();

  final micromimetroFabricante = TextEditingController();
  final micromimetroTipo = TextEditingController();
  final micromimetroData = TextEditingController();

  final megometroFabricante = TextEditingController();
  final megometroTipo = TextEditingController();
  final megometroData = TextEditingController();

  final oscilografoFabricante = TextEditingController();
  final oscilografoTipo = TextEditingController();
  final oscilografoData = TextEditingController();

  CaracterizacaoEnsaio? caracterizacaoSelecionada;

  // Disjuntor
  final disjuntorFabricante = TextEditingController();
  final disjuntorAnoFabricacao = TextEditingController();
  final disjuntorTensaoNominal = TextEditingController();
  final disjuntorCorrenteNominal = TextEditingController();
  final disjuntorCapInterrupcaoNominal = TextEditingController();
  TipoExtinsaoDisjuntor? tipoExtinsaoSelecionado;
  final disjuntorTipoAcionamento = TextEditingController();
  final disjuntorPressaoSf6Nominal = TextEditingController();
  final disjuntorPressaoSf6NominalTemperatura = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = Get.find<MpDjFormController>();

    final form = controller.formulario.value;
    if (form != null) {
      termohigrometroFabricante.text = form.termohigrometroFabricante ?? '';
      termohigrometroTipo.text = form.termohigrometroTipo ?? '';
      termohigrometroData.text =
          form.termohigrometroUltimaCalibracao?.toIso8601String() ?? '';

      micromimetroFabricante.text = form.micromimetroFabricante ?? '';
      micromimetroTipo.text = form.micromimetroTipo ?? '';
      micromimetroData.text =
          form.micromimetroUltimaCalibracao?.toIso8601String() ?? '';

      megometroFabricante.text = form.megometroFabricante ?? '';
      megometroTipo.text = form.megometroTipo ?? '';
      megometroData.text =
          form.megometroUltimaCalibracao?.toIso8601String() ?? '';

      oscilografoFabricante.text = form.oscilografoFabricante ?? '';
      oscilografoTipo.text = form.oscilografoTipo ?? '';
      oscilografoData.text =
          form.oscilografoUltimaCalibracao?.toIso8601String() ?? '';

      caracterizacaoSelecionada = form.caracterizacaoEnsaio;

      disjuntorFabricante.text = form.disjuntorFabricante ?? '';
      disjuntorAnoFabricacao.text = form.disjuntorAnoFabricacao ?? '';
      disjuntorTensaoNominal.text =
          form.disjuntorTensaoNominal?.toString() ?? '';
      disjuntorCorrenteNominal.text =
          form.disjuntorCorrenteNominal?.toString() ?? '';
      disjuntorCapInterrupcaoNominal.text =
          form.disjuntorCapInterrupcaoNominal?.toString() ?? '';
      tipoExtinsaoSelecionado = form.disjuntorTipoExtinsao;
      disjuntorTipoAcionamento.text = form.disjuntorTipoAcionamento ?? '';
      disjuntorPressaoSf6Nominal.text =
          form.disjuntorPressaoSf6Nominal?.toString() ?? '';
      disjuntorPressaoSf6NominalTemperatura.text =
          form.disjuntorPressaoSf6NominalTemperatura?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    termohigrometroFabricante.dispose();
    termohigrometroTipo.dispose();
    termohigrometroData.dispose();
    micromimetroFabricante.dispose();
    micromimetroTipo.dispose();
    micromimetroData.dispose();
    megometroFabricante.dispose();
    megometroTipo.dispose();
    megometroData.dispose();
    oscilografoFabricante.dispose();
    oscilografoTipo.dispose();
    oscilografoData.dispose();
    disjuntorFabricante.dispose();
    disjuntorAnoFabricacao.dispose();
    disjuntorTensaoNominal.dispose();
    disjuntorCorrenteNominal.dispose();
    disjuntorCapInterrupcaoNominal.dispose();
    disjuntorTipoAcionamento.dispose();
    disjuntorPressaoSf6Nominal.dispose();
    disjuntorPressaoSf6NominalTemperatura.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados Iniciais - MPDJ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              controller.salvarFormularioFromControllers(
                termohigrometroFabricante: termohigrometroFabricante.text,
                termohigrometroTipo: termohigrometroTipo.text,
                termohigrometroData: termohigrometroData.text,
                micromimetroFabricante: micromimetroFabricante.text,
                micromimetroTipo: micromimetroTipo.text,
                micromimetroData: micromimetroData.text,
                megometroFabricante: megometroFabricante.text,
                megometroTipo: megometroTipo.text,
                megometroData: megometroData.text,
                oscilografoFabricante: oscilografoFabricante.text,
                oscilografoTipo: oscilografoTipo.text,
                oscilografoData: oscilografoData.text,
                caracterizacaoEnsaio: caracterizacaoSelecionada,
                disjuntorFabricante: disjuntorFabricante.text,
                disjuntorAnoFabricacao: disjuntorAnoFabricacao.text,
                disjuntorTensaoNominal: disjuntorTensaoNominal.text,
                disjuntorCorrenteNominal: disjuntorCorrenteNominal.text,
                disjuntorCapInterrupcaoNominal:
                    disjuntorCapInterrupcaoNominal.text,
                disjuntorTipoExtinsao: tipoExtinsaoSelecionado,
                disjuntorTipoAcionamento: disjuntorTipoAcionamento.text,
                disjuntorPressaoSf6Nominal: disjuntorPressaoSf6Nominal.text,
                disjuntorPressaoSf6NominalTemperatura:
                    disjuntorPressaoSf6NominalTemperatura.text,
              );
            },
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
              _buildInstrumentoSection('Termohigrômetro', [
                CampoTexto(
                    label: 'Fabricante', controller: termohigrometroFabricante),
                CampoTexto(label: 'Tipo', controller: termohigrometroTipo),
                CampoData(
                    label: 'Última Calibração',
                    controller: termohigrometroData),
              ]),
              _buildInstrumentoSection('Micromímetro', [
                CampoTexto(
                    label: 'Fabricante', controller: micromimetroFabricante),
                CampoTexto(label: 'Tipo', controller: micromimetroTipo),
                CampoData(
                    label: 'Última Calibração', controller: micromimetroData),
              ]),
              _buildInstrumentoSection('Megômetro', [
                CampoTexto(
                    label: 'Fabricante', controller: megometroFabricante),
                CampoTexto(label: 'Tipo', controller: megometroTipo),
                CampoData(
                    label: 'Última Calibração', controller: megometroData),
              ]),
              _buildInstrumentoSection('Oscilógrafo', [
                CampoTexto(
                    label: 'Fabricante', controller: oscilografoFabricante),
                CampoTexto(label: 'Tipo', controller: oscilografoTipo),
                CampoData(
                    label: 'Última Calibração', controller: oscilografoData),
              ]),
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
        title:
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
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
        title: const Text('Dados do Disjuntor',
            style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          CampoSelectEnum<CaracterizacaoEnsaio>(
            label: 'Caracterização do Ensaio',
            valorSelecionado: caracterizacaoSelecionada,
            valores: CaracterizacaoEnsaio.values,
            labelBuilder: (e) => e.label,
            onChanged: (v) => setState(() => caracterizacaoSelecionada = v),
          ),
          CampoTexto(label: 'Fabricante', controller: disjuntorFabricante),
          CampoTexto(
              label: 'Ano de Fabricação', controller: disjuntorAnoFabricacao),
          CampoTexto(
              label: 'Tensão Nominal (kV)', controller: disjuntorTensaoNominal),
          CampoTexto(
              label: 'Corrente Nominal (A)',
              controller: disjuntorCorrenteNominal),
          CampoTexto(
              label: 'Capacidade de Interrupção (kA)',
              controller: disjuntorCapInterrupcaoNominal),
          CampoSelectEnum<TipoExtinsaoDisjuntor>(
            label: 'Tipo de Extinção',
            valorSelecionado: tipoExtinsaoSelecionado,
            valores: TipoExtinsaoDisjuntor.values,
            labelBuilder: (e) => e.name.toUpperCase(),
            onChanged: (v) => setState(() => tipoExtinsaoSelecionado = v),
          ),
          CampoTexto(
              label: 'Tipo de Acionamento',
              controller: disjuntorTipoAcionamento),
          CampoTexto(
              label: 'Pressão SF6 Nominal (bar)',
              controller: disjuntorPressaoSf6Nominal),
          CampoTexto(
              label: 'Temperatura Nominal SF6 (°C)',
              controller: disjuntorPressaoSf6NominalTemperatura),
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
