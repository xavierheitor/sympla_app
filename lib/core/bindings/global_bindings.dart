import 'package:get/get.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/services/sync/equipamento_sync_service.dart';
import 'package:sympla_app/core/services/sync/grupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/subgrupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/sync_orchestrator_service.dart';
import 'package:sympla_app/core/services/sync/tipo_atividade_sync_service.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/data/repositories/auth_repository_impl.dart';
import 'package:sympla_app/data/repositories/usuario_repository_impl.dart';
import 'package:sympla_app/domain/repositories/auth_repository.dart';
import 'package:sympla_app/domain/repositories/usuario_repository.dart';
import 'package:sympla_app/services/auth_service.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Core
    Get.put<AppDatabase>(AppDatabase(), permanent: true);
    Get.lazyPut<DioClient>(() => DioClient(), fenix: true);

    // Repositórios
    Get.lazyPut<UsuarioRepository>(() => UsuarioRepositoryImpl(Get.find()));
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find<DioClient>().dio));

    // Services
    Get.lazyPut<AuthService>(() => AuthService(Get.find(), Get.find()));

    Get.put<SessionManager>(
      SessionManager(
        db: Get.find<AppDatabase>(),
        authService: Get.find<AuthService>(),
      ),
      permanent: true, // opcional, mas útil aqui
    );

    Get.lazyPut(() => TipoAtividadeSyncService(
          dio: Get.find(),
          dao: Get.find<AppDatabase>().tipoAtividadeDao,
        ));

    Get.lazyPut(() => EquipamentoSyncService(
          dio: Get.find(),
          dao: Get.find<AppDatabase>().equipamentoDao,
        ));

    Get.lazyPut(() => GrupoDefeitoSyncService(
          dio: Get.find(),
          dao: Get.find<AppDatabase>().grupoDefeitoEquipamentoDao,
        ));

    Get.lazyPut(() => SubgrupoDefeitoSyncService(
          dio: Get.find(),
          dao: Get.find<AppDatabase>().subgrupoDefeitoEquipamentoDao,
        ));

// Deve ser o último!
    Get.lazyPut(() => SyncOrchestratorService(
          tipoAtividadeSyncService: Get.find(),
          equipamentoSyncService: Get.find(),
          grupoDefeitoSyncService: Get.find(),
          subgrupoDefeitoSyncService: Get.find(),
        ));
  }
}
