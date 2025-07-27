import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_resposta_table_dto.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';
import 'package:sympla_app/modules/checklist/checklist_service.dart';

class ChecklistController extends GetxController {
  final ChecklistService service;
  final AtividadeController atividadeController;

  ChecklistController({
    required this.service,
    required this.atividadeController,
  });

  //lista de perguntas
  final _perguntas = <ChecklistPerguntaTableDto>[].obs;

  //respostas
  final _respostas = <String, RespostaChecklist>{}.obs;

  //carregando
  final _carregando = false.obs;

  //checklist preenchido
  int? _checklistPreenchidoId;
  bool _salvouFormulario = false;

  //pega as perguntas
  List<ChecklistPerguntaTableDto> get perguntas => _perguntas;

  //pega as respostas
  Map<String, RespostaChecklist> get respostas => _respostas;

  //pega se esta carregando
  bool get carregando => _carregando.value;

  @override
  void onInit() {
    super.onInit();
    verificarChecklistJaRespondido();
  }

  Future<void> verificarChecklistJaRespondido() async {
    final atividade = atividadeController.atividadeEmAndamento.value;
    if (atividade == null) {
      return;
    }

    final jaRespondido = await service.checklistJaRespondido(atividade.uuid);
    if (jaRespondido) {
      await atividadeController.avancar();
      return;
    }

    await carregarPerguntas();
  }

  //carrega o checklist
  Future<void> carregarPerguntas() async {
    _carregando.value = true;
    try {
      AppLogger.d(
          '[ChecklistController] Iniciando carregamento do checklist...');

      final atividade = atividadeController.atividadeEmAndamento.value;
      if (atividade == null) {
        AppLogger.e(
            '[ChecklistController] Nenhuma atividade em andamento disponível');
        throw Exception('Nenhuma atividade em andamento.');
      }

      final checklist =
          await service.buscarChecklistDaAtividade(atividade.tipoAtividadeId);

      final perguntasRelacionadas =
          await service.buscarPerguntasRelacionadas(checklist.uuid);
      AppLogger.d(
          '[ChecklistController] Total de perguntas relacionadas: ${perguntasRelacionadas.length}');
      if (perguntasRelacionadas.isEmpty) {
        AppLogger.w(
            '[ChecklistController] Nenhuma pergunta encontrada para o checklist ${checklist.uuid}');
      }

      _perguntas.value = perguntasRelacionadas;
      //TODO: ADICIONAR TRATAMENTO DE ERRO QUANDO NAO ENCONTRAR CHECKLISR PRA O TIPO DE ATIVIDADE

      // Criar checklist preenchido vazio
      _checklistPreenchidoId = await service.criarChecklistPreenchido(
          atividade.uuid, checklist.uuid);
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
    _respostas.refresh();
  }

  //salva as respostas no banco de dados
  Future<void> salvarRespostas() async {
    final atividade = atividadeController.atividadeEmAndamento.value;
    if (atividade == null) {
      AppLogger.w(
          '[ChecklistController] Tentativa de salvar respostas sem uma atividade ativa');
      return;
    }

    if (_checklistPreenchidoId == null) {
      AppLogger.w(
          '[ChecklistController] Tentativa de salvar respostas sem um checklist preenchido');
      return;
    }

    final lista = _respostas.entries.map((entry) {
      AppLogger.d(
          '[ChecklistController] Preparando resposta para pergunta ${entry.key}: ${entry.value}');
      return ChecklistRespostaTableDto(
        checklistPreenchidoId: _checklistPreenchidoId!,
        perguntaId: entry.key,
        resposta: entry.value,
      );
    }).toList();

    AppLogger.d(
        '[ChecklistController] Total de respostas para salvar: ${lista.length}');
    await service.salvarRespostas(lista);

    // Atualizar data de preenchimento
    await service.atualizarDataPreenchimentoChecklistPreenchido(
        _checklistPreenchidoId!, DateTime.now());

    _salvouFormulario = true;

    //avanca para a proxima etapa
    await atividadeController.avancar();
  }

  Future<bool> checklistJaRespondido(String atividadeId) async {
    return await service.checklistJaRespondido(atividadeId);
  }

  @override
  void onClose() {
    // Se não salvou o formulário, deleta o checklist preenchido
    if (_checklistPreenchidoId != null && !_salvouFormulario) {
      AppLogger.d('[ChecklistController] Deletando checklist preenchido: $_checklistPreenchidoId');
      service.deletarChecklistPreenchido(_checklistPreenchidoId!);
    }
    super.onClose();
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
