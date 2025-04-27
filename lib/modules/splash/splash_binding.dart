import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/services/sync/atividade_sync_service.dart';
import 'package:sympla_app/core/services/sync/equipamento_sync_service.dart';
import 'package:sympla_app/core/services/sync/grupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/subgrupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/sync_orchestrator_service.dart';
import 'package:sympla_app/core/services/sync/tipo_atividade_sync_service.dart';
import 'package:sympla_app/data/repositories/atividade_repository_impl.dart';
import 'package:sympla_app/data/repositories/equipamento_repository_impl.dart';
import 'package:sympla_app/data/repositories/grupo_defeito_repository_impl.dart';
import 'package:sympla_app/data/repositories/subgrupo_defeito_repository_impl.dart';
import 'package:sympla_app/data/repositories/tipo_atividade_repository_impl.dart';
import 'package:sympla_app/domain/repositories/atividade_repository.dart';
import 'package:sympla_app/domain/repositories/equipamento_repository.dart';
import 'package:sympla_app/domain/repositories/grupo_defeito_repository.dart';
import 'package:sympla_app/domain/repositories/subgrupo_defeito_repository.dart';
import 'package:sympla_app/domain/repositories/tipo_atividade_repository.dart';
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

    // Sync Services (recriados automaticamente se deletados)
    Get.lazyPut(() => TipoAtividadeSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => EquipamentoSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => GrupoDefeitoSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => SubgrupoDefeitoSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => AtividadeSyncService(Get.find()), fenix: true);

    // Orquestrador
    Get.lazyPut(
        () => SyncOrchestratorService(
              tipoAtividadeSyncService: Get.find(),
              equipamentoSyncService: Get.find(),
              grupoDefeitoSyncService: Get.find(),
              subgrupoDefeitoSyncService: Get.find(),
            ),
        fenix: true);

    Get.lazyPut(() => SplashController());

    Get.put(AtividadeController(atividadeSyncService: Get.find()),
        permanent: true);
  }
}
