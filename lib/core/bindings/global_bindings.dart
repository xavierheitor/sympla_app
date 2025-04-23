import 'package:get/get.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/storage/app_database.dart';

import 'package:sympla_app/data/repositories/auth_repository_impl.dart';
import 'package:sympla_app/data/repositories/equipamento_repository_impl.dart';
import 'package:sympla_app/data/repositories/grupo_defeito_repository_impl.dart';
import 'package:sympla_app/data/repositories/subgrupo_defeito_repository_impl.dart';
import 'package:sympla_app/data/repositories/tipo_atividade_repository_impl.dart';
import 'package:sympla_app/data/repositories/usuario_repository_impl.dart';
import 'package:sympla_app/domain/repositories/auth_repository.dart';
import 'package:sympla_app/domain/repositories/equipamento_repository.dart';
import 'package:sympla_app/domain/repositories/grupo_defeito_repository.dart';
import 'package:sympla_app/domain/repositories/subgrupo_defeito_repository.dart';
import 'package:sympla_app/domain/repositories/tipo_atividade_repository.dart';
import 'package:sympla_app/domain/repositories/usuario_repository.dart';

import 'package:sympla_app/services/auth_service.dart';

import 'package:sympla_app/core/services/sync/tipo_atividade_sync_service.dart';
import 'package:sympla_app/core/services/sync/equipamento_sync_service.dart';
import 'package:sympla_app/core/services/sync/grupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/subgrupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/sync_orchestrator_service.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Core resources
    Get.put(AppDatabase(), permanent: true);
    Get.put(DioClient(), permanent: true);

    // repositories
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut<UsuarioRepository>(() => UsuarioRepositoryImpl(Get.find()),
        fenix: true);
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

    // Core ervices
    Get.put(AuthService(Get.find(), Get.find()), permanent: true);
    Get.put(SessionManager(Get.find(), db: Get.find(), authService: Get.find()),
        permanent: true);

    // Sync Services (recriados automaticamente se deletados)
    Get.lazyPut(() => TipoAtividadeSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => EquipamentoSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => GrupoDefeitoSyncService(Get.find()), fenix: true);
    Get.lazyPut(() => SubgrupoDefeitoSyncService(Get.find()), fenix: true);

    // Orquestrador
    Get.lazyPut(
        () => SyncOrchestratorService(
              tipoAtividadeSyncService: Get.find(),
              equipamentoSyncService: Get.find(),
              grupoDefeitoSyncService: Get.find(),
              subgrupoDefeitoSyncService: Get.find(),
            ),
        fenix: true);

    // futuros services adicione aqui
  }
}
