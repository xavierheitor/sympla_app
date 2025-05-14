import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_resposta_table_dto.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/checklist/checklist_service.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';

class ChecklistController extends GetxController {
  final ChecklistService checklistService;
  final AtividadeController atividadeController;

  ChecklistController({
    required this.checklistService,
    required this.atividadeController,
  });

  //lista de perguntas
  final _perguntas = <ChecklistPerguntaTableDto>[].obs;

  //respostas
  final _respostas = <String, RespostaChecklist>{}.obs;

  //carregando
  final _carregando = false.obs;

  //pega as perguntas
  List<ChecklistPerguntaTableDto> get perguntas => _perguntas;

  //pega as respostas
  Map<String, RespostaChecklist> get respostas => _respostas;

  //pega se esta carregando
  bool get carregando => _carregando.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    AppLogger.d('[ChecklistController] Inicializando controller...');

    //pega a atividade em andamento
    final atividade = atividadeController.atividadeEmAndamento.value;
    if (atividade == null) {
      AppLogger.e('[ChecklistController] Nenhuma atividade em andamento');
      return;
    }

    //verifica se o checklist ja foi respondido
    final jaRespondido =
        await checklistService.checklistJaRespondido(atividade.uuid);
    if (jaRespondido) {
      AppLogger.d(
          '[ChecklistController] Checklist já respondido. Redirecionando para próxima etapa...');
      await atividadeController
          .avancar(); // Deixa o controller global cuidar disso
      return;
    }

    //carrega o checklist
    await carregarChecklist();
  }

  //verifica se o checklist ja foi respondido
  Future<void> checklistJaRespondido() async {
    final atividade = atividadeController.atividadeEmAndamento;

    if (atividade.value == null) {
      AppLogger.e('[ChecklistController] Nenhuma atividade em andamento');
      throw Exception('Nenhuma atividade em andamento.');
    }

    final jaRespondido =
        await checklistService.checklistJaRespondido(atividade.value!.uuid);

    if (jaRespondido) {
      AppLogger.e(
          '[ChecklistController] Checklist já foi respondido anteriormente');
      Get.offAllNamed(Routes.resumoAnomalias);
    }
  }

  //carrega o checklist
  Future<void> carregarChecklist() async {
    try {
      _carregando.value = true;
      AppLogger.d(
          '[ChecklistController] Iniciando carregamento do checklist...');

      final atividade = atividadeController.atividadeEmAndamento;
      if (atividade.value == null) {
        AppLogger.e(
            '[ChecklistController] Nenhuma atividade em andamento disponível');
        throw Exception('Nenhuma atividade em andamento.');
      }

      final checklist = await checklistService
          .buscarChecklistDaAtividade(atividade.value!.uuid);

      final perguntasRelacionadas =
          await checklistService.buscarPerguntasRelacionadas(checklist.uuid);
      AppLogger.d(
          '[ChecklistController] Total de perguntas relacionadas: ${perguntasRelacionadas.length}');
      if (perguntasRelacionadas.isEmpty) {
        AppLogger.w(
            '[ChecklistController] Nenhuma pergunta encontrada para o checklist ${checklist.uuid}');
      }

      _perguntas.assignAll(perguntasRelacionadas);
    } catch (e, s) {
      AppLogger.e('[ChecklistController] Erro ao carregar checklist',
          error: e, stackTrace: s);
      rethrow;
    } finally {
      _carregando.value = false;
      AppLogger.d('[ChecklistController] Carregamento do checklist finalizado');
    }
  }

  //registra a resposta de uma pergunta
  void registrarResposta(String perguntaId, RespostaChecklist resposta) {
    AppLogger.d(
        '[ChecklistController] Registrando resposta: pergunta $perguntaId → ${resposta.name}');
    _respostas[perguntaId] = resposta;
  }

  //salva as respostas no banco de dados
  Future<void> salvarRespostas() async {
    final atividade = atividadeController.atividadeEmAndamento;
    if (atividade.value == null) {
      AppLogger.w(
          '[ChecklistController] Tentativa de salvar respostas sem uma atividade ativa');
      return;
    }

    final lista = _respostas.entries.map((entry) {
      AppLogger.d(
          '[ChecklistController] Preparando resposta para pergunta ${entry.key}: ${entry.value}');
      return ChecklistRespostaTableDto(
        checklistPreenchidoId: 0,
        perguntaId: entry.key.toString(),
        resposta: entry.value,
      );
    }).toList();

    AppLogger.d(
        '[ChecklistController] Total de respostas para salvar: ${lista.length}');
    await checklistService.salvarRespostas(lista);

    //avanca para a proxima etapa
    await atividadeController.avancar();
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
