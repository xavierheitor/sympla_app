import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/domain/dto/mpdj/prev_disj_form_table_dto.dart';
import 'package:sympla_app/core/storage/converters/caracterizacao_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_extinsao_disjutnor_converter.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';
import 'package:sympla_app/modules/mp_dj/widgets/campo_select.dart';
import 'package:sympla_app/modules/mp_dj/widgets/campo_texto.dart';

class MpDjFormPage extends StatefulWidget {
  const MpDjFormPage({super.key});

  @override
  State<MpDjFormPage> createState() => _MpDjFormPageState();
}

class _MpDjFormPageState extends State<MpDjFormPage> {
  late MpDjFormController controller;

  final disjuntorFabricante = TextEditingController();
  final disjuntorAnoFabricacao = TextEditingController();
  final disjuntorTensaoNominal = TextEditingController();
  final disjuntorCorrenteNominal = TextEditingController();
  final disjuntorCapInterrupcaoNominal = TextEditingController();
  final disjuntorTipoAcionamento = TextEditingController();
  final disjuntorPressaoSf6Nominal = TextEditingController();
  final disjuntorPressaoSf6NominalTemperatura = TextEditingController();

  CaracterizacaoEnsaio? caracterizacaoSelecionada;
  TipoExtinsaoDisjuntor? tipoExtinsaoSelecionado;

  @override
  void initState() {
    super.initState();
    controller = Get.find<MpDjFormController>();

    final form = controller.formulario.value;
    if (form != null) {
      _preencherCampos(form);
    }
  }

  void _preencherCampos(MpdjFormTableDto form) {
    caracterizacaoSelecionada =
        CaracterizacaoEnsaio.values.byName(form.caracterizacaoEnsaio ?? '');
    tipoExtinsaoSelecionado =
        TipoExtinsaoDisjuntor.values.byName(form.disjuntorTipoExtinsao ?? '');

    disjuntorFabricante.text = form.disjuntorFabricante ?? '';
    disjuntorAnoFabricacao.text = form.disjuntorAnoFabricacao ?? '';
    disjuntorTensaoNominal.text =
        (form.disjuntorTensaoNominal ?? '').toString();
    disjuntorCorrenteNominal.text =
        (form.disjuntorCorrenteNominal ?? '').toString();
    disjuntorCapInterrupcaoNominal.text =
        (form.disjuntorCapInterrupcaoNominal ?? '').toString();
    disjuntorTipoAcionamento.text = form.disjuntorTipoAcionamento ?? '';
    disjuntorPressaoSf6Nominal.text =
        (form.disjuntorPressaoSf6Nominal ?? '').toString();
    disjuntorPressaoSf6NominalTemperatura.text =
        (form.disjuntorPressaoSf6NominalTemperatura ?? '').toString();
  }

  @override
  void dispose() {
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

  void _salvar() {
    controller.salvarFormularioFromControllers(
      caracterizacaoEnsaio: caracterizacaoSelecionada,
      disjuntorFabricante: disjuntorFabricante.text,
      disjuntorAnoFabricacao: disjuntorAnoFabricacao.text,
      disjuntorTensaoNominal: disjuntorTensaoNominal.text,
      disjuntorCorrenteNominal: disjuntorCorrenteNominal.text,
      disjuntorCapInterrupcaoNominal: disjuntorCapInterrupcaoNominal.text,
      disjuntorTipoExtinsao: tipoExtinsaoSelecionado,
      disjuntorTipoAcionamento: disjuntorTipoAcionamento.text,
      disjuntorPressaoSf6Nominal: disjuntorPressaoSf6Nominal.text,
      disjuntorPressaoSf6NominalTemperatura:
          disjuntorPressaoSf6NominalTemperatura.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados do Disjuntor'),
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
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CampoSelectEnum<CaracterizacaoEnsaio>(
                    label: 'Caracterização do Ensaio',
                    valorSelecionado: caracterizacaoSelecionada,
                    valores: CaracterizacaoEnsaio.values,
                    labelBuilder: (e) => e.label,
                    onChanged: (v) =>
                        setState(() => caracterizacaoSelecionada = v),
                  ),
                  CampoTexto(
                      label: 'Fabricante', controller: disjuntorFabricante),
                  CampoTexto(
                      label: 'Ano de Fabricação',
                      controller: disjuntorAnoFabricacao),
                  CampoTexto(
                      label: 'Tensão Nominal (kV)',
                      controller: disjuntorTensaoNominal),
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
                    onChanged: (v) =>
                        setState(() => tipoExtinsaoSelecionado = v),
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
