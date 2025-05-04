import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/caracterizacao_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_extinsao_disjutnor_converter.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_service.dart';
import 'package:drift/drift.dart' as d;

class MpDjFormController extends GetxController {
  final MpDjFormService service;
  final AtividadeController atividadeController;

  MpDjFormController({
    required this.service,
    required this.atividadeController,
  });

  var carregando = false.obs;
  var etapaAtual = 0.obs;

  Rxn<PrevDisjFormData> formulario = Rxn();
  var resistenciasContato = <MedicaoResistenciaContatoTableData>[].obs;
  var isolamentos = <MedicaoResistenciaIsolamentoTableData>[].obs;
  var tempos = <MedicaoTempoOperacaoTableData>[].obs;
  var pressoes = <MedicaoPressaoSf6TableData>[].obs;

  int get atividadeId {
    final atividade = atividadeController.atividadeEmAndamento.value;
    if (atividade == null) {
      AppLogger.e('[MpDjFormController] ERRO: atividadeEmAndamento está nula!');
      throw Exception(
          '[MpDjFormController] Nenhuma atividade em andamento encontrada');
    }
    return atividade.id;
  }

  @override
  void onInit() {
    super.onInit();
    AppLogger.d('[MpDjFormController] onInit chamado');
    _carregarDadosIniciais();
  }

  Future<void> _carregarDadosIniciais() async {
    try {
      carregando.value = true;
      AppLogger.d(
          '[MpDjFormController] Iniciando carregamento de dados da atividade $atividadeId');

      final form = await service.buscarFormulario(atividadeId);
      formulario.value = form;
      AppLogger.d('[MpDjFormController] Formulário carregado: ${form?.id}');

      if (form != null) {
        final id = form.id;
        AppLogger.d(
            '[MpDjFormController] Carregando medições para formulário id=$id');
        resistenciasContato.value = await service.buscarResistenciaContato(id);
        isolamentos.value = await service.buscarResistenciaIsolamento(id);
        tempos.value = await service.buscarTempoOperacao(id);
        pressoes.value = await service.buscarPressaoSf6(id);
      } else {
        AppLogger.w(
            '[MpDjFormController] Nenhum formulário encontrado para a atividade. Etapa começa em 1.');
      }

      _definirEtapaAtual();
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] ERRO ao carregar dados iniciais',
          error: e, stackTrace: s);
    } finally {
      carregando.value = false;
    }
  }

  void _definirEtapaAtual() {
    AppLogger.d('[MpDjFormController] Determinando etapa atual...');
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
    AppLogger.d(
        '[MpDjFormController] Etapa atual definida: ${etapaAtual.value}');
  }

  Future<void> salvarFormularioFromControllers({
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
      AppLogger.d('[MpDjFormController] Salvando formulário...');

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

      AppLogger.d('[MpDjFormController] Dados montados, salvando no banco...');
      await service.salvarFormulario(dados);

      AppLogger.d('[MpDjFormController] Formulário salvo. Recarregando...');
      await _carregarDadosIniciais();

      AppLogger.d(
          '[MpDjFormController] Redirecionando para a próxima etapa...');
      await _redirecionar();
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] ERRO ao salvar formulário',
          error: e, stackTrace: s);
      Get.snackbar('Erro', 'Falha ao salvar dados.');
    } finally {
      carregando.value = false;
    }
  }

  Future<void> salvarResistenciasContato(
      List<MedicaoResistenciaContatoTableCompanion> dados) async {
    try {
      final id = formulario.value?.id;
      AppLogger.d(
          '[MpDjFormController] Salvando resistências de contato (formId: $id)...');
      if (id != null) {
        await service.salvarResistenciaContato(id, dados);
        resistenciasContato.value = await service.buscarResistenciaContato(id);
        _definirEtapaAtual();
        await _redirecionar();
      }
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] ERRO ao salvar resistência de contato',
          error: e, stackTrace: s);
    }
  }

  Future<void> salvarIsolamentos(
      List<MedicaoResistenciaIsolamentoTableCompanion> dados) async {
    try {
      final id = formulario.value?.id;
      AppLogger.d('[MpDjFormController] Salvando isolamentos (formId: $id)...');
      if (id != null) {
        await service.salvarResistenciaIsolamento(id, dados);
        isolamentos.value = await service.buscarResistenciaIsolamento(id);
        _definirEtapaAtual();
        await _redirecionar();
      }
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] ERRO ao salvar isolamento',
          error: e, stackTrace: s);
    }
  }

  Future<void> salvarTempos(
      List<MedicaoTempoOperacaoTableCompanion> dados) async {
    try {
      final id = formulario.value?.id;
      AppLogger.d(
          '[MpDjFormController] Salvando tempos de operação (formId: $id)...');
      if (id != null) {
        await service.salvarTempoOperacao(id, dados);
        tempos.value = await service.buscarTempoOperacao(id);
        _definirEtapaAtual();
        await _redirecionar();
      }
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] ERRO ao salvar tempo de operação',
          error: e, stackTrace: s);
    }
  }

  Future<void> salvarPressaoSf6(
      List<MedicaoPressaoSf6TableCompanion> dados) async {
    try {
      final id = formulario.value?.id;
      AppLogger.d('[MpDjFormController] Salvando pressão SF6 (formId: $id)...');
      if (id != null) {
        await service.salvarPressaoSf6(id, dados);
        pressoes.value = await service.buscarPressaoSf6(id);
        _definirEtapaAtual();
        await atividadeController.avancar(); // ✅ Etapa final
      }
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] ERRO ao salvar pressão SF6',
          error: e, stackTrace: s);
    }
  }

  Future<void> _redirecionar() async {
    final etapa = etapaAtual.value;
    AppLogger.d('[MpDjFormController] Redirecionando com etapaAtual=$etapa');

    switch (etapa) {
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
      case 5:
        AppLogger.d('[MpDjFormController] Finalizando atividade...');
        await atividadeController.avancar();
        break;
      default:
        AppLogger.w(
            '[MpDjFormController] Etapa inválida ou indefinida. Redirecionando para etapa 1.');
        etapaAtual.value = 1;
        Get.toNamed(Routes.etapaResistenciaContato);
        break;
    }
  }

  DateTime? _tryParseDate(String input) {
    try {
      return input.trim().isEmpty ? null : DateTime.tryParse(input.trim());
    } catch (_) {
      AppLogger.w('[MpDjFormController] Falha ao converter data: "$input"');
      return null;
    }
  }

  double? _tryParseDouble(String input) {
    try {
      return input.trim().isEmpty ? null : double.tryParse(input.trim());
    } catch (_) {
      AppLogger.w('[MpDjFormController] Falha ao converter double: "$input"');
      return null;
    }
  }
}
