import 'package:get/get.dart';
import 'package:sympla_app/core/data/repositories/apr/apr_perguntas_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/checklist_grupo_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/checklist_pergunta_relacionamento_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/checklist_pergunta_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/checklist_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/checklist_subgrupo_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/defeito_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/tecnicos_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/apr/apr_perguntas_repository.dart';
import 'package:sympla_app/core/domain/repositories/apr/apr_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_grupo_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_relacionamento_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_subgrupo_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/tecnicos_repository.dart';
import 'package:sympla_app/core/services/sync/apr_sync_service.dart';
import 'package:sympla_app/core/services/sync/atividade_sync_service.dart';
import 'package:sympla_app/core/services/sync/checklist/checklist_sync_service.dart';
import 'package:sympla_app/core/services/sync/checklist/defeitos_sync_service.dart';
import 'package:sympla_app/core/services/sync/equipamento_sync_service.dart';
import 'package:sympla_app/core/services/sync/grupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/subgrupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/sync_orchestrator_service.dart';
import 'package:sympla_app/core/services/sync/tecnicos_sync_service.dart';
import 'package:sympla_app/core/services/sync/tipo_atividade_sync_service.dart';
import 'package:sympla_app/core/data/repositories/atividade/atividade_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/equipamento_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/grupo_defeito_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/subgrupo_defeito_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/apr/apr_repository_impl.dart';

import 'package:sympla_app/core/data/repositories/atividade/tipo_atividade_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/atividade/atividade_repository.dart';
import 'package:sympla_app/core/domain/repositories/equipamento_repository.dart';
import 'package:sympla_app/core/domain/repositories/grupo_defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/subgrupo_defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/atividade/tipo_atividade_repository.dart';
import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TipoAtividadeRepository>(
      () => TipoAtividadeRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );
    Get.lazyPut<EquipamentoRepository>(
      () => EquipamentoRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );
    Get.lazyPut<GrupoDefeitoRepository>(
      () => GrupoDefeitoRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );
    Get.lazyPut<SubgrupoDefeitoRepository>(
      () => SubgrupoDefeitoRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );

    Get.lazyPut<AtividadeRepository>(
      () => AtividadeRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );

    Get.lazyPut<AprRepository>(
      () => AprRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );

    Get.lazyPut<AprPerguntasRepository>(
      () => AprPerguntasRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );

    Get.lazyPut<TecnicosRepository>(
      () => TecnicosRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );

    Get.lazyPut<DefeitoRepository>(
      () => DefeitoRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );

    Get.lazyPut<ChecklistRepository>(
      () => ChecklistRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );

    Get.lazyPut<ChecklistPerguntaRepository>(
      () => ChecklistPerguntaRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );

    Get.lazyPut<ChecklistPerguntaRelacionamentoRepository>(
      () => ChecklistPerguntaRelacionamentoRepositoryImpl(
          dio: Get.find(), db: Get.find()),
      fenix: true,
    );

    Get.lazyPut<ChecklistGrupoRepository>(
      () => ChecklistGrupoRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );

    Get.lazyPut<ChecklistSubgrupoRepository>(
      () => ChecklistSubgrupoRepositoryImpl(dio: Get.find(), db: Get.find()),
      fenix: true,
    );

    // Sync Services (recriados automaticamente se deletados)
    Get.lazyPut(() => TipoAtividadeSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => EquipamentoSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => GrupoDefeitoSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => SubgrupoDefeitoSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => AtividadeSyncService(Get.find()), fenix: true);
    Get.lazyPut(
        () => AprSyncService(
              aprRepository: Get.find(),
              aprPerguntaRepository: Get.find(),
            ),
        fenix: true);
    Get.lazyPut(() => TecnicosSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => DefeitosSyncService(Get.find()), fenix: true);
    Get.lazyPut(
        () => ChecklistSyncService(
              checklistRepository: Get.find(),
              checklistPerguntaRelacionamentoRepository: Get.find(),
              checklistPerguntaRepository: Get.find(),
              checklistGrupoRepository: Get.find(),
              checklistSubgrupoRepository: Get.find(),
            ),
        fenix: true);

    // Orquestrador
    Get.lazyPut(
        () => SyncOrchestratorService(
              tipoAtividadeSyncService: Get.find(),
              equipamentoSyncService: Get.find(),
              grupoDefeitoSyncService: Get.find(),
              subgrupoDefeitoSyncService: Get.find(),
              aprSyncService: Get.find(),
              tecnicosSyncService: Get.find(),
              defeitosSyncService: Get.find(),
              checklistSyncService: Get.find(),
            ),
        fenix: true);

    Get.lazyPut(() => SplashController());

    // Get.put(AtividadeController(atividadeSyncService: Get.find()),
    //     permanent: true);
  }
}
