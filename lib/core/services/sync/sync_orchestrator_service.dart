import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/services/sync/equipamento_sync_service.dart';
import 'package:sympla_app/core/services/sync/grupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/subgrupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/tipo_atividade_sync_service.dart';

class SyncOrchestratorService {
  final TipoAtividadeSyncService tipoAtividadeSyncService;
  final EquipamentoSyncService equipamentoSyncService;
  final GrupoDefeitoSyncService grupoDefeitoSyncService;
  final SubgrupoDefeitoSyncService subgrupoDefeitoSyncService;

  SyncOrchestratorService({
    required this.tipoAtividadeSyncService,
    required this.equipamentoSyncService,
    required this.grupoDefeitoSyncService,
    required this.subgrupoDefeitoSyncService,
  });

  Future<void> sincronizarTudo() async {
    AppLogger.i('🚀 Iniciando sincronização geral', tag: 'SyncOrchestrator');

    try {
      await grupoDefeitoSyncService.sincronizar();
      await subgrupoDefeitoSyncService.sincronizar();
      await tipoAtividadeSyncService.sincronizar();
      await equipamentoSyncService.sincronizar();

      AppLogger.i('✅ Sincronização geral concluída com sucesso',
          tag: 'SyncOrchestrator');
    } catch (e, s) {
      AppLogger.e('❌ Erro durante sincronização geral',
          tag: 'SyncOrchestrator', error: e, stackTrace: s);
    }
  }
}
