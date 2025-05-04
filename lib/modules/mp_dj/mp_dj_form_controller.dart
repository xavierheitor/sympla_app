import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/caracterizacao_ensaio_converter.dart';
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

  @override
  void onInit() {
    super.onInit();
    _carregarDadosIniciais();
  }

  Future<void> _carregarDadosIniciais() async {
    try {
      carregando.value = true;
      AppLogger.d(
          '[MpDjFormController] Carregando formulário da atividade \$atividadeId');

      final form = await service.buscarFormulario(atividadeId);
      formulario.value = form;

      if (form != null) {
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
    AppLogger.d('[MpDjFormController] Etapa atual: \${etapaAtual.value}');
  }

  Future<void> salvarEDirecionar(PrevDisjFormCompanion companion) async {
    try {
      carregando.value = true;
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

  Future<void> salvarEDirecionarComCampos({
    required String termohigrometroFabricante,
    required String termohigrometroTipo,
    required String termohigrometroData,
    required String micromimetroFabricante,
    required String micromimetroTipo,
    required String micromimetroData,
    required String megometroFabricante,
    required String megometroTipo,
    required String megometroData,
    required String oscilografoFabricante,
    required String oscilografoTipo,
    required String oscilografoData,
    required CaracterizacaoEnsaio? caracterizacaoEnsaio,
    required String disjuntorFabricante,
    required String disjuntorAnoFabricacao,
    required String disjuntorTensaoNominal,
    required String disjuntorCorrenteNominal,
    required String disjuntorCapInterrupcaoNominal,
    required TipoExtinsaoDisjuntor? disjuntorTipoExtinsao,
    required String disjuntorTipoAcionamento,
    required String disjuntorPressaoSf6Nominal,
    required String disjuntorPressaoSf6NominalTemperatura,
  }) async {
    try {
      carregando.value = true;

      final dados = PrevDisjFormCompanion(
        atividadeId: d.Value(atividadeId),
        termohigrometroFabricante: d.Value(termohigrometroFabricante.trim()),
        termohigrometroTipo: d.Value(termohigrometroTipo.trim()),
        termohigrometroUltimaCalibracao:
            d.Value(_tryParseDate(termohigrometroData)),
        micromimetroFabricante: d.Value(micromimetroFabricante.trim()),
        micromimetroTipo: d.Value(micromimetroTipo.trim()),
        micromimetroUltimaCalibracao: d.Value(_tryParseDate(micromimetroData)),
        megometroFabricante: d.Value(megometroFabricante.trim()),
        megometroTipo: d.Value(megometroTipo.trim()),
        megometroUltimaCalibracao: d.Value(_tryParseDate(megometroData)),
        oscilografoFabricante: d.Value(oscilografoFabricante.trim()),
        oscilografoTipo: d.Value(oscilografoTipo.trim()),
        oscilografoUltimaCalibracao: d.Value(_tryParseDate(oscilografoData)),
        caracterizacaoEnsaio: d.Value(caracterizacaoEnsaio),
        disjuntorFabricante: d.Value(disjuntorFabricante.trim()),
        disjuntorAnoFabricacao: d.Value(disjuntorAnoFabricacao.trim()),
        disjuntorTensaoNominal:
            d.Value(_tryParseDouble(disjuntorTensaoNominal)),
        disjuntorCorrenteNominal:
            d.Value(_tryParseDouble(disjuntorCorrenteNominal)?.toInt()),
        disjuntorCapInterrupcaoNominal:
            d.Value(_tryParseDouble(disjuntorCapInterrupcaoNominal)?.toInt()),
        disjuntorTipoExtinsao: d.Value(disjuntorTipoExtinsao),
        disjuntorTipoAcionamento: d.Value(disjuntorTipoAcionamento.trim()),
        disjuntorPressaoSf6Nominal:
            d.Value(_tryParseDouble(disjuntorPressaoSf6Nominal)),
        disjuntorPressaoSf6NominalTemperatura:
            d.Value(_tryParseDouble(disjuntorPressaoSf6NominalTemperatura)),
      );

      await service.salvarFormulario(dados);
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
      AppLogger.e(
          '[MpDjFormController] Erro ao salvar com campos e redirecionar',
          error: e,
          stackTrace: s);
      Get.snackbar('Erro', 'Falha ao salvar dados.');
    } finally {
      carregando.value = false;
    }
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
}
