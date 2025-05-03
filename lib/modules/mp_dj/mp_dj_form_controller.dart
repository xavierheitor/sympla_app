import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/tipo_extinsao_disjutnor_converter.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_service.dart';
import 'package:drift/drift.dart' as d;

class MpDjFormController extends GetxController {
  final MpDjFormService service;
  final int atividadeId;

  MpDjFormController({required this.service, required this.atividadeId});

  var carregando = false.obs;
  var etapaAtual = 0.obs;

  Rxn<PrevDisjFormData> formulario = Rxn();
  var resistenciasContato = <MedicaoResistenciaContatoTableData>[].obs;
  var isolamentos = <MedicaoResistenciaIsolamentoTableData>[].obs;
  var tempos = <MedicaoTempoOperacaoTableData>[].obs;
  var pressoes = <MedicaoPressaoSf6TableData>[].obs;

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

  // Disjuntor
  final disjuntorFabricante = TextEditingController();
  final disjuntorAnoFabricacao = TextEditingController();
  final disjuntorTensaoNominal = TextEditingController();
  final disjuntorCorrenteNominal = TextEditingController();
  final disjuntorCapInterrupcaoNominal = TextEditingController();
  final disjuntorTipoExtinsao = TextEditingController();
  final disjuntorTipoAcionamento = TextEditingController();
  final disjuntorPressaoSf6Nominal = TextEditingController();
  final disjuntorPressaoSf6NominalTemperatura = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _carregarDadosIniciais();
  }

  Future<void> _carregarDadosIniciais() async {
    try {
      carregando.value = true;
      AppLogger.d(
          '[MpDjFormController] Carregando formulário da atividade $atividadeId');

      final form = await service.buscarFormulario(atividadeId);
      formulario.value = form;

      if (form != null) {
        _preencherCamposComFormulario(form);
        final id = form.id;
        resistenciasContato.value = await service.buscarResistenciaContato(id);
        isolamentos.value = await service.buscarResistenciaIsolamento(id);
        tempos.value = await service.buscarTempoOperacao(id);
        pressoes.value = await service.buscarPressaoSf6(id);
        _definirEtapaAtual();
      } else {
        etapaAtual.value = 0;
      }
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] Erro ao carregar dados',
          error: e, stackTrace: s);
    } finally {
      carregando.value = false;
    }
  }

  void _preencherCamposComFormulario(PrevDisjFormData form) {
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

    disjuntorFabricante.text = form.disjuntorFabricante ?? '';
    disjuntorAnoFabricacao.text = form.disjuntorAnoFabricacao ?? '';
    disjuntorTensaoNominal.text = form.disjuntorTensaoNominal?.toString() ?? '';
    disjuntorCorrenteNominal.text =
        form.disjuntorCorrenteNominal?.toString() ?? '';
    disjuntorCapInterrupcaoNominal.text =
        form.disjuntorCapInterrupcaoNominal?.toString() ?? '';
    disjuntorTipoExtinsao.text = form.disjuntorTipoExtinsao?.name ?? '';
    disjuntorTipoAcionamento.text = form.disjuntorTipoAcionamento ?? '';
    disjuntorPressaoSf6Nominal.text =
        form.disjuntorPressaoSf6Nominal?.toString() ?? '';
    disjuntorPressaoSf6NominalTemperatura.text =
        form.disjuntorPressaoSf6NominalTemperatura?.toString() ?? '';
  }

  void _definirEtapaAtual() {
    if (resistenciasContato.isEmpty) {
      etapaAtual.value = 1;
    } else if (isolamentos.isEmpty) {
      etapaAtual.value = 2;
    } else if (tempos.isEmpty) {
      etapaAtual.value = 3;
    } else if (pressoes.isEmpty) {
      etapaAtual.value = 4;
    } else {
      etapaAtual.value = 5;
    }
    AppLogger.d('[MpDjFormController] Etapa atual: ${etapaAtual.value}');
  }

  Future<void> salvarEDirecionar() async {
    try {
      carregando.value = true;

      final companion = _montarCompanion();
      await service.salvarFormulario(companion);
      await _carregarDadosIniciais();

      switch (etapaAtual.value) {
        case 1:
          Get.toNamed(Routes.etapaResistenciaContato);
          break;
        case 2:
          Get.toNamed(Routes.etapaIsolamento);
          break;
        case 3:
          Get.toNamed(Routes.etapaTempoOperacao);
          break;
        case 4:
          Get.toNamed(Routes.etapaPressaoSf6);
          break;
        default:
          Get.back();
      }
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] Erro ao salvar e redirecionar',
          error: e, stackTrace: s);
      Get.snackbar('Erro', 'Falha ao salvar dados iniciais.');
    } finally {
      carregando.value = false;
    }
  }

  PrevDisjFormCompanion _montarCompanion() {
    return PrevDisjFormCompanion(
      atividadeId: d.Value(atividadeId),
      termohigrometroFabricante: d.Value(termohigrometroFabricante.text.trim()),
      termohigrometroTipo: d.Value(termohigrometroTipo.text.trim()),
      termohigrometroUltimaCalibracao:
          d.Value(_tryParseDate(termohigrometroData.text)),
      micromimetroFabricante: d.Value(micromimetroFabricante.text.trim()),
      micromimetroTipo: d.Value(micromimetroTipo.text.trim()),
      micromimetroUltimaCalibracao:
          d.Value(_tryParseDate(micromimetroData.text)),
      megometroFabricante: d.Value(megometroFabricante.text.trim()),
      megometroTipo: d.Value(megometroTipo.text.trim()),
      megometroUltimaCalibracao: d.Value(_tryParseDate(megometroData.text)),
      oscilografoFabricante: d.Value(oscilografoFabricante.text.trim()),
      oscilografoTipo: d.Value(oscilografoTipo.text.trim()),
      oscilografoUltimaCalibracao: d.Value(_tryParseDate(oscilografoData.text)),
      disjuntorFabricante: d.Value(disjuntorFabricante.text.trim()),
      disjuntorAnoFabricacao: d.Value(disjuntorAnoFabricacao.text.trim()),
      disjuntorTensaoNominal:
          d.Value(_tryParseDouble(disjuntorTensaoNominal.text)),
      disjuntorCorrenteNominal:
          d.Value(_tryParseDouble(disjuntorCorrenteNominal.text) as int?),
      disjuntorCapInterrupcaoNominal:
          d.Value(_tryParseDouble(disjuntorCapInterrupcaoNominal.text) as int?),
      disjuntorTipoExtinsao:
          d.Value(_tryParseTipoExtinsao(disjuntorTipoExtinsao.text)),
      disjuntorTipoAcionamento: d.Value(disjuntorTipoAcionamento.text.trim()),
      disjuntorPressaoSf6Nominal:
          d.Value(_tryParseDouble(disjuntorPressaoSf6Nominal.text)),
      disjuntorPressaoSf6NominalTemperatura:
          d.Value(_tryParseDouble(disjuntorPressaoSf6NominalTemperatura.text)),
    );
  }

  DateTime? _tryParseDate(String input) {
    try {
      if (input.trim().isEmpty) return null;
      return DateTime.tryParse(input.trim());
    } catch (_) {
      return null;
    }
  }

  double? _tryParseDouble(String input) {
    try {
      if (input.trim().isEmpty) return null;
      return double.tryParse(input.trim());
    } catch (_) {
      return null;
    }
  }

  TipoExtinsaoDisjuntor? _tryParseTipoExtinsao(String input) {
    final texto = input.trim().toLowerCase();
    if (texto == 'sf6') return TipoExtinsaoDisjuntor.sf6;
    if (texto == 'vácuo' || texto == 'vacuo')
      return TipoExtinsaoDisjuntor.vacuo;
    if (texto == 'gás' || texto == 'gas') return TipoExtinsaoDisjuntor.gvo;
    return null;
  }

  Future<void> salvarResistenciasContato(
      List<MedicaoResistenciaContatoTableCompanion> dados) async {
    try {
      final id = formulario.value?.id;
      if (id != null) {
        await service.salvarResistenciaContato(id, dados);
        resistenciasContato.value = await service.buscarResistenciaContato(id);
        _definirEtapaAtual();
        Get.back();
      }
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] Erro ao salvar resistência de contato',
          error: e, stackTrace: s);
    }
  }

  Future<void> salvarIsolamentos(
      List<MedicaoResistenciaIsolamentoTableCompanion> dados) async {
    try {
      final id = formulario.value?.id;
      if (id != null) {
        await service.salvarResistenciaIsolamento(id, dados);
        isolamentos.value = await service.buscarResistenciaIsolamento(id);
        _definirEtapaAtual();
        Get.back();
      }
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] Erro ao salvar isolamentos',
          error: e, stackTrace: s);
    }
  }

  Future<void> salvarTempos(
      List<MedicaoTempoOperacaoTableCompanion> dados) async {
    try {
      final id = formulario.value?.id;
      if (id != null) {
        await service.salvarTempoOperacao(id, dados);
        tempos.value = await service.buscarTempoOperacao(id);
        _definirEtapaAtual();
        Get.back();
      }
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] Erro ao salvar tempos',
          error: e, stackTrace: s);
    }
  }

  Future<void> salvarPressaoSf6(
      List<MedicaoPressaoSf6TableCompanion> dados) async {
    try {
      final id = formulario.value?.id;
      if (id != null) {
        await service.salvarPressaoSf6(id, dados);
        pressoes.value = await service.buscarPressaoSf6(id);
        _definirEtapaAtual();
        Get.back();
      }
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] Erro ao salvar pressão SF6',
          error: e, stackTrace: s);
    }
  }

  @override
  void onClose() {
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
    disjuntorTipoExtinsao.dispose();
    disjuntorTipoAcionamento.dispose();
    disjuntorPressaoSf6Nominal.dispose();
    disjuntorPressaoSf6NominalTemperatura.dispose();
    super.onClose();
  }
}
