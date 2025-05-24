import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_pressao_sf6_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_contato_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_isolamento_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_tempo_operacao_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/prev_disj_form_table_dto.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/converters/caracterizacao_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_extinsao_disjutnor_converter.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_service.dart';

/// 🎛️ Controller para o módulo MPDJ
class MpDjFormController extends GetxController {
  final MpDjFormService service;
  final AtividadeController atividadeController;

  MpDjFormController({
    required this.service,
    required this.atividadeController,
  });

  final carregando = false.obs;
  final etapaAtual = 0.obs;

  final formulario = Rxn<MpdjFormTableDto>();
  final resistenciasContato = <MedicaoResistenciaContatoTableDto>[].obs;
  final isolamentos = <MedicaoResistenciaIsolamentoTableDto>[].obs;
  final tempos = <MedicaoTempoOperacaoTableDto>[].obs;
  final pressoes = <MedicaoPressaoSf6TableDto>[].obs;

  String get atividadeId {
    final atividade = atividadeController.atividadeEmAndamento.value;
    if (atividade == null) {
      AppLogger.e('[MpDjFormController] Nenhuma atividade em andamento');
      throw Exception('Nenhuma atividade em andamento');
    }
    return atividade.uuid;
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
      AppLogger.d('[MpDjFormController] Carregando dados iniciais');

      final form = await service.buscarFormulario(atividadeId);
      formulario.value = form;

      if (form != null) {
        final id = form.id;
        resistenciasContato.value = await service.buscarResistenciaContato(id!);
        isolamentos.value = await service.buscarResistenciaIsolamento(id);
        tempos.value = await service.buscarTempoOperacao(id);
        pressoes.value = await service.buscarPressaoSf6(id);
      }

      _definirEtapaAtual();
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] Erro no carregamento inicial',
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
    AppLogger.d('[MpDjFormController] Etapa atual: ${etapaAtual.value}');
  }

  // ========================= 💾 SALVAR FORMULÁRIO =========================
  Future<void> salvarFormularioFromControllers({
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

      final dados = MpdjFormTableDto(
        id: formulario.value?.id ?? 0,
        atividadeId: atividadeId,
        dataEnsaio: DateTime.now(),
        caracterizacaoEnsaio: caracterizacaoEnsaio?.name,
        disjuntorFabricante: disjuntorFabricante,
        disjuntorAnoFabricacao: disjuntorAnoFabricacao,
        disjuntorTensaoNominal: _parseDouble(disjuntorTensaoNominal),
        disjuntorCorrenteNominal: _parseInt(disjuntorCorrenteNominal),
        disjuntorCapInterrupcaoNominal:
            _parseInt(disjuntorCapInterrupcaoNominal),
        disjuntorTipoExtinsao: disjuntorTipoExtinsao?.name,
        disjuntorTipoAcionamento: disjuntorTipoAcionamento,
        disjuntorPressaoSf6Nominal: _parseDouble(disjuntorPressaoSf6Nominal),
        disjuntorPressaoSf6NominalTemperatura:
            _parseDouble(disjuntorPressaoSf6NominalTemperatura),
      );

      final id = await service.salvarFormulario(dados);
      AppLogger.d('[MpDjFormController] Formulário salvo (id: $id)');

      await _carregarDadosIniciais();
      await _redirecionar();
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] Erro ao salvar formulário',
          error: e, stackTrace: s);
      Get.snackbar('Erro', 'Falha ao salvar dados');
    } finally {
      carregando.value = false;
    }
  }

  // ========================= 💾 SALVAR MEDIÇÕES =========================
  Future<void> salvarResistenciasContato(
      List<MedicaoResistenciaContatoTableDto> dados) async {
    await _salvarEtapa(
      () => service.salvarResistenciaContato(formulario.value!.id!, dados),
      () => service.buscarResistenciaContato(formulario.value!.id!),
      resistenciasContato,
    );
  }

  Future<void> salvarIsolamentos(
      List<MedicaoResistenciaIsolamentoTableDto> dados) async {
    await _salvarEtapa(
      () => service.salvarResistenciaIsolamento(formulario.value!.id!, dados),
      () => service.buscarResistenciaIsolamento(formulario.value!.id!),
      isolamentos,
    );
  }

  Future<void> salvarTempos(List<MedicaoTempoOperacaoTableDto> dados) async {
    await _salvarEtapa(
      () => service.salvarTempoOperacao(formulario.value!.id!, dados),
      () => service.buscarTempoOperacao(formulario.value!.id!),
      tempos,
    );
  }

  Future<void> salvarPressaoSf6(List<MedicaoPressaoSf6TableDto> dados) async {
    await _salvarEtapa(
      () => service.salvarPressaoSf6(formulario.value!.id!, dados),
      () => service.buscarPressaoSf6(formulario.value!.id!),
      pressoes,
      finalizar: true,
    );
  }

  // ========================= 🔀 NAVEGAÇÃO ENTRE ETAPAS =========================
  Future<void> _redirecionar() async {
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
      case 5:
        await atividadeController.avancar();
        break;
      default:
        etapaAtual.value = 1;
        Get.toNamed(Routes.etapaResistenciaContato);
    }
  }

  // ========================= 🛠️ UTILS =========================
  double _parseDouble(String valor) {
    return double.tryParse(valor.replaceAll(',', '.').trim()) ?? 0.0;
  }

  int _parseInt(String valor) {
    return int.tryParse(valor.trim()) ?? 0;
  }

  Future<void> _salvarEtapa<T>(
    Future<void> Function() salvar,
    Future<List<T>> Function() buscar,
    RxList<T> destino, {
    bool finalizar = false,
  }) async {
    try {
      carregando.value = true;
      await salvar();
      destino.value = await buscar();
      _definirEtapaAtual();
      finalizar ? await atividadeController.avancar() : await _redirecionar();
    } catch (e, s) {
      AppLogger.e('[MpDjFormController] Erro ao salvar etapa',
          error: e, stackTrace: s);
    } finally {
      carregando.value = false;
    }
  }
}
