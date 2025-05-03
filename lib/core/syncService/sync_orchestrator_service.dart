import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/syncService/apr/apr_sync_service.dart';
import 'package:sympla_app/core/syncService/checklist/checklist_sync_service.dart';
import 'package:sympla_app/core/syncService/defeito/defeitos_sync_service.dart';
import 'package:sympla_app/core/syncService/equipamento/equipamento_sync_service.dart';
import 'package:sympla_app/core/syncService/defeito/grupo_defeito_sync_service.dart';
import 'package:sympla_app/core/syncService/defeito/subgrupo_defeito_sync_service.dart';
import 'package:sympla_app/core/syncService/tecnicos/tecnicos_sync_service.dart';
import 'package:sympla_app/core/syncService/atividade/tipo_atividade_sync_service.dart';

class SyncOrchestratorService {
  final TipoAtividadeSyncService tipoAtividadeSyncService;
  final EquipamentoSyncService equipamentoSyncService;
  final GrupoDefeitoSyncService grupoDefeitoSyncService;
  final SubgrupoDefeitoSyncService subgrupoDefeitoSyncService;
  final AprSyncService aprSyncService;
  final TecnicosSyncService tecnicosSyncService;
  final DefeitosSyncService defeitosSyncService;
  final ChecklistSyncService checklistSyncService;

  SyncOrchestratorService({
    required this.tipoAtividadeSyncService,
    required this.equipamentoSyncService,
    required this.grupoDefeitoSyncService,
    required this.subgrupoDefeitoSyncService,
    required this.aprSyncService,
    required this.tecnicosSyncService,
    required this.defeitosSyncService,
    required this.checklistSyncService,
  });

  Future<void> sincronizarTudo() async {
    AppLogger.i('🚀 Iniciando sincronização geral', tag: 'SyncOrchestrator');

    try {
      await grupoDefeitoSyncService.sincronizar();
      await subgrupoDefeitoSyncService.sincronizar();
      await tipoAtividadeSyncService.sincronizar();
      await equipamentoSyncService.sincronizar();
      // apr
      await aprSyncService.sincronizarAprs();
      await aprSyncService.sincronizarPerguntas();
      await aprSyncService.sincronizarPerguntaRelacionamentos();
      await tecnicosSyncService.sincronizar();
      // defeitos
      await defeitosSyncService.sincronizar();
      //checklists
      await checklistSyncService.sincronizarChecklistPergunta();
      await checklistSyncService.sincronizarChecklistPerguntaRelacionamento();
      await checklistSyncService.sincronizarChecklist();
      await checklistSyncService.sincronizarChecklistGrupo();
      await checklistSyncService.sincronizarChecklistSubgrupo();

      AppLogger.i('✅ Sincronização geral concluída com sucesso',
          tag: 'SyncOrchestrator');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[sync_orchestrator_service - sincronizarTudo] ${erro.mensagem}',
          tag: 'SyncOrchestrator',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<bool> estaVazio() async {
    return await tipoAtividadeSyncService.estaVazio() ||
        await equipamentoSyncService.estaVazio() ||
        await grupoDefeitoSyncService.estaVazio() ||
        await subgrupoDefeitoSyncService.estaVazio();
  }
}
