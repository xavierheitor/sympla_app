import 'package:sympla_app/core/domain/repositories/checklist/checklist_grupo_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_relacionamento_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_subgrupo_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class ChecklistSyncService {
  final ChecklistRepository checklistRepository;
  final ChecklistPerguntaRelacionamentoRepository
      checklistPerguntaRelacionamentoRepository;
  final ChecklistPerguntaRepository checklistPerguntaRepository;
  final ChecklistGrupoRepository checklistGrupoRepository;
  final ChecklistSubgrupoRepository checklistSubgrupoRepository;

  ChecklistSyncService({
    required this.checklistRepository,
    required this.checklistPerguntaRelacionamentoRepository,
    required this.checklistPerguntaRepository,
    required this.checklistGrupoRepository,
    required this.checklistSubgrupoRepository,
  });

  Future<void> sincronizarChecklist() async {
    try {
      AppLogger.d('🔄 Iniciando sincronização de Checklist',
          tag: 'ChecklistSyncService');
      final lista = await checklistRepository.buscarDaApi();
      await checklistRepository.salvarNoBanco(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistSyncService - sincronizarChecklist] ${erro.mensagem}',
          tag: 'ChecklistSyncService',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> sincronizarChecklistGrupo() async {
    try {
      AppLogger.d('🔄 Iniciando sincronização de Checklist Grupo',
          tag: 'ChecklistSyncService');
      final lista = await checklistGrupoRepository.buscarDaApi();
      await checklistGrupoRepository.salvarNoBanco(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistSyncService - sincronizarChecklistGrupo] ${erro.mensagem}',
          tag: 'ChecklistSyncService',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> sincronizarChecklistSubgrupo() async {
    try {
      AppLogger.d('🔄 Iniciando sincronização de Checklist Subgrupo',
          tag: 'ChecklistSyncService');
      final lista = await checklistSubgrupoRepository.buscarDaApi();
      await checklistSubgrupoRepository.salvarNoBanco(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistSyncService - sincronizarChecklistSubgrupo] ${erro.mensagem}',
          tag: 'ChecklistSyncService',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> sincronizarChecklistPergunta() async {
    try {
      AppLogger.d('🔄 Iniciando sincronização de Checklist Pergunta',
          tag: 'ChecklistSyncService');
      final lista = await checklistPerguntaRepository.buscarDaApi();
      await checklistPerguntaRepository.salvarNoBanco(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistSyncService - sincronizarChecklistPergunta] ${erro.mensagem}',
          tag: 'ChecklistSyncService',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> sincronizarChecklistPerguntaRelacionamento() async {
    try {
      AppLogger.d(
          '🔄 Iniciando sincronização de Checklist Pergunta Relacionamento',
          tag: 'ChecklistSyncService');
      final lista =
          await checklistPerguntaRelacionamentoRepository.buscarDaApi();
      await checklistPerguntaRelacionamentoRepository.salvarNoBanco(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistSyncService - sincronizarChecklistPerguntaRelacionamento] ${erro.mensagem}',
          tag: 'ChecklistSyncService',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
