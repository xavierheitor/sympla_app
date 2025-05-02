import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/services/checklist_service.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';
import 'package:drift/drift.dart' as d;

class ChecklistController extends GetxController {
  final ChecklistService checklistService;
  final AtividadeController atividadeController;

  ChecklistController({
    required this.checklistService,
    required this.atividadeController,
  });

  final _perguntas = <ChecklistPerguntaTableData>[].obs;
  final _relacionamentos = <ChecklistPerguntaRelacionamentoTableData>[].obs;
  final _respostas = <int, RespostaChecklist>{}.obs;
  final _carregando = false.obs;

  List<ChecklistPerguntaTableData> get perguntas => _perguntas;
  Map<int, RespostaChecklist> get respostas => _respostas;
  bool get carregando => _carregando.value;

  Map<GrupoSubgrupoKey, List<ChecklistPerguntaTableData>>
      get perguntasPorGrupoSubgrupo {
    final Map<GrupoSubgrupoKey, List<ChecklistPerguntaTableData>> mapa = {};

    for (final rel in _relacionamentos) {
      final pergunta =
          _perguntas.firstWhereOrNull((p) => p.id == rel.perguntaId);
      if (pergunta == null) {
        AppLogger.w(
            '[ChecklistController] Pergunta com id ${rel.perguntaId} não encontrada entre perguntas carregadas');
        continue;
      }

      final key = GrupoSubgrupoKey(
        grupoId: rel.grupoId,
        subgrupoId: rel.subgrupoId,
      );

      mapa.putIfAbsent(key, () => []).add(pergunta);
    }

    AppLogger.d(
        '[ChecklistController] Total de grupos/subgrupos únicos: ${mapa.length}');
    return mapa;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    AppLogger.d('[ChecklistController] Inicializando controller...');
    await checklistJaRespondido();
    carregarChecklist();
  }

  Future<void> checklistJaRespondido() async {
    final atividade = atividadeController.atividadeEmAndamento;

    if (atividade.value == null) {
      AppLogger.e('[ChecklistController] Nenhuma atividade em andamento');
      throw Exception('Nenhuma atividade em andamento.');
    }

    final jaRespondido =
        await checklistService.checklistJaRespondido(atividade.value!.id);

    if (jaRespondido) {
      AppLogger.e('[ChecklistController] Checklist já respondido');
      Get.offAllNamed(Routes.resumoAnomalias);
    }
  }

  Future<void> carregarChecklist() async {
    try {
      _carregando.value = true;
      AppLogger.d(
          '[ChecklistController] Iniciando carregamento do checklist...');

      final atividade = atividadeController.atividadeEmAndamento;
      if (atividade.value == null) {
        AppLogger.e('[ChecklistController] Nenhuma atividade em andamento');
        throw Exception('Nenhuma atividade em andamento.');
      }

      AppLogger.d(
          '[ChecklistController] Atividade atual: id=${atividade.value!.id}, tipo=${atividade.value!.tipoAtividadeId}');

      final checklist = await checklistService
          .buscarChecklistDaAtividade(atividade.value!.id);
      AppLogger.d(
          '[ChecklistController] Checklist carregado: id=${checklist.id}, nome=${checklist.nome}');

      final perguntasRelacionadas =
          await checklistService.buscarPerguntasRelacionadas(checklist.id);
      AppLogger.d(
          '[ChecklistController] Perguntas relacionadas carregadas: ${perguntasRelacionadas.length}');

      final relacionamentos =
          await checklistService.buscarRelacionamentos(checklist.id);
      AppLogger.d(
          '[ChecklistController] Relacionamentos carregados: ${relacionamentos.length}');

      _perguntas.assignAll(perguntasRelacionadas);
      _relacionamentos.assignAll(relacionamentos);
    } catch (e, s) {
      AppLogger.e('[ChecklistController] Erro ao carregar checklist',
          error: e, stackTrace: s);
      rethrow;
    } finally {
      _carregando.value = false;
      AppLogger.d('[ChecklistController] Finalizado carregamento do checklist');
    }
  }

  void registrarResposta(int perguntaId, RespostaChecklist resposta) {
    AppLogger.d(
        '[ChecklistController] Registrando resposta para pergunta $perguntaId: ${resposta.name}');
    _respostas[perguntaId] = resposta;
  }

  Future<void> salvarRespostas() async {
    final atividade = atividadeController.atividadeEmAndamento;
    if (atividade.value == null) {
      AppLogger.w(
          '[ChecklistController] Tentativa de salvar respostas sem atividade');
      return;
    }

    final lista = _respostas.entries.map((entry) {
      AppLogger.d(
          '[ChecklistController] Montando resposta: pergunta ${entry.key}, resposta ${entry.value}');
      return ChecklistRespostaTableCompanion(
        perguntaId: d.Value(entry.key),
        atividadeId: d.Value(atividade.value!.id),
        resposta: d.Value(entry.value),
      );
    }).toList();

    AppLogger.d(
        '[ChecklistController] Total de respostas a salvar: ${lista.length}');
    await checklistService.salvarRespostas(lista);
  }
}

class GrupoSubgrupoKey {
  final int grupoId;
  final int subgrupoId;

  GrupoSubgrupoKey({required this.grupoId, required this.subgrupoId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrupoSubgrupoKey &&
          runtimeType == other.runtimeType &&
          grupoId == other.grupoId &&
          subgrupoId == other.subgrupoId;

  @override
  int get hashCode => grupoId.hashCode ^ subgrupoId.hashCode;
}
