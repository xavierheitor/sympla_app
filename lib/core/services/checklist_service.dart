import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_grupo_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_resposta_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_subgrupo_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_relacionamento_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/equipamento_repository.dart';
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
  final EquipamentoRepository equipamentoRepository;
  final DefeitoRepository defeitoRepository;
  ChecklistService({
    required this.checklistRepository,
    required this.grupoRepository,
    required this.subgrupoRepository,
    required this.perguntaRepository,
    required this.relacionamentoRepository,
    required this.respostaRepository,
    required this.equipamentoRepository,
    required this.defeitoRepository,
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
      final perguntas = await perguntaRepository.getAll();

      AppLogger.d('🔢 Total de perguntas no banco: ${perguntas.length}');
      AppLogger.d(
          '🧩 Total de relacionamentos encontrados: ${relacionamentos.length}');
      AppLogger.d(
          '📋 IDs das perguntas disponíveis: ${perguntas.map((e) => e.id).toList()}');
      AppLogger.d(
          '📌 IDs dos relacionamentos: ${relacionamentos.map((e) => e.perguntaId).toList()}');

      final relacionadas = perguntas
          .where((p) => relacionamentos.any((r) => r.perguntaId == p.id))
          .toList();

      AppLogger.d('✅ Perguntas relacionadas filtradas: ${relacionadas.length}');

      return relacionadas;
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
        AppLogger.d(
            '↳ Resposta: perguntaId=${resposta.perguntaId.value}, atividadeId=${resposta.atividadeId.value}, resposta=${resposta.resposta.value}');
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
      AppLogger.d('🔍 Buscando respostas para atividade $atividadeId');
      final respostas = await respostaRepository.getByAtividadeId(atividadeId);
      AppLogger.d('📋 Total de respostas encontradas: ${respostas.length}');
      return respostas;
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

  Future<ChecklistTableData> buscarChecklistDaAtividade(int id) async {
    try {
      AppLogger.d(
          '🔍 Buscando checklist da atividade $id (tipoAtividadeId: $id)',
          tag: 'ChecklistService');
      return await buscarChecklistPorTipoAtividade(id);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistService - buscarChecklistDaAtividade] ${erro.mensagem}',
          tag: 'ChecklistService',
          error: erro.mensagem,
          stackTrace: erro.stack);
      rethrow;
    }
  }

  Future<List<ChecklistPerguntaRelacionamentoTableData>> buscarRelacionamentos(
      int checklistId) async {
    try {
      AppLogger.d('📎 Buscando relacionamentos do checklist $checklistId');
      final lista =
          await relacionamentoRepository.buscarPorChecklistId(checklistId);
      AppLogger.d('📌 Total de relacionamentos: ${lista.length}');
      return lista;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - buscarRelacionamentos] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<EquipamentoTableData>> buscarEquipamentos(
      String subestacao) async {
    try {
      return await equipamentoRepository.buscarPorSubestacao(subestacao);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - buscarEquipamentos] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<DefeitoTableData>> buscarDefeitos(
      EquipamentoTableData equipamento) async {
    try {
      return await defeitoRepository.buscarPorEquipamento(equipamento);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - buscarDefeitos] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }
}
