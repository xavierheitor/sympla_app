import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_grupo_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_resposta_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_subgrupo_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_relacionamento_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class ChecklistService {
  final ChecklistRepository checklistRepository;
  final ChecklistGrupoRepository grupoRepository;
  final ChecklistSubgrupoRepository subgrupoRepository;
  final ChecklistPerguntaRepository perguntaRepository;
  final ChecklistPerguntaRelacionamentoRepository relacionamentoRepository;
  final ChecklistRespostaRepository respostaRepository;

  ChecklistService({
    required this.checklistRepository,
    required this.grupoRepository,
    required this.subgrupoRepository,
    required this.perguntaRepository,
    required this.relacionamentoRepository,
    required this.respostaRepository,
  });

  Future<ChecklistTableData> buscarChecklistPorTipoAtividade(
      int tipoAtividadeId) async {
    try {
      AppLogger.d(
          '🔍 Buscando checklist por tipoAtividadeId: $tipoAtividadeId');
      final checklist =
          await checklistRepository.buscarPorTipoAtividade(tipoAtividadeId);
      if (checklist == null) {
        throw Exception(
            'Checklist não encontrado para o tipo de atividade $tipoAtividadeId');
      }
      return checklist;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistService - buscarChecklistPorTipoAtividade] ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<List<ChecklistPerguntaTableData>> buscarPerguntasRelacionadas(
      int checklistId) async {
    try {
      AppLogger.d(
          '📋 Buscando perguntas relacionadas ao checklist $checklistId');
      final relacionamentos =
          await relacionamentoRepository.buscarPorChecklistId(checklistId);
      final perguntas = await perguntaRepository
          .getAll(); // ou otimizar por IDs dos relacionamentos
      return perguntas
          .where((p) => relacionamentos.any((r) => r.perguntaId == p.id))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistService - buscarPerguntasRelacionadas] ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarRespostas(
      List<ChecklistRespostaTableCompanion> respostas) async {
    try {
      AppLogger.d('💾 Salvando ${respostas.length} respostas de checklist');
      for (final resposta in respostas) {
        await respostaRepository.insert(resposta);
      }
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - salvarRespostas] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<ChecklistRespostaTableData>> buscarRespostas(
      int atividadeId) async {
    try {
      return await respostaRepository.getByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - buscarRespostas] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> deletarRespostas(int atividadeId) async {
    try {
      await respostaRepository.deleteByAtividadeId(atividadeId);
      AppLogger.d(
          '🗑️ Respostas do checklist da atividade $atividadeId removidas');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - deletarRespostas] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }
}
