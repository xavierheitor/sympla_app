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
import 'package:sympla_app/core/services/sync/equipamento_sync_service.dart';
import 'package:sympla_app/core/services/sync/grupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/subgrupo_defeito_sync_service.dart';
import 'package:sympla_app/core/services/sync/tipo_atividade_sync_service.dart';
import 'package:sympla_app/core/services/sync/sync_orchestrator_service.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Banco de dados
    Get.put<AppDatabase>(AppDatabase(), permanent: true);

    // Repositório de usuário
    Get.lazyPut<UsuarioRepository>(
        () => UsuarioRepositoryImpl(Get.find<AppDatabase>()));

    // Repositório Auth inicial (sem Dio ainda, será reescrito depois)
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find<DioClient>()),
        fenix: true);

    // Serviço de autenticação
    Get.lazyPut(
        () => AuthService(
            Get.find<AuthRepository>(), Get.find<UsuarioRepository>()),
        fenix: true);

    // Gerenciador de sessão
    Get.lazyPut(() => SessionManager(Get.find<AppDatabase>(),
        db: Get.find<AppDatabase>(), authService: Get.find<AuthService>()));

    // DioClient com SessionManager resolvido
    Get.lazyPut(() => DioClient(Get.find<SessionManager>()), fenix: true);

    // Rebind do AuthRepository com Dio resolvido
    Get.lazyReplace<AuthRepository>(
        () => AuthRepositoryImpl(Get.find<DioClient>()));

    // Repositórios principais
    Get.lazyPut<EquipamentoRepository>(() => EquipamentoRepositoryImpl(
          dio: Get.find(),
          dao: Get.find<AppDatabase>().equipamentoDao,
        ));

    Get.lazyPut<TipoAtividadeRepository>(() => TipoAtividadeRepositoryImpl(
          dio: Get.find(),
          dao: Get.find<AppDatabase>().tipoAtividadeDao,
        ));

    Get.lazyPut<GrupoDefeitoRepository>(() => GrupoDefeitoRepositoryImpl(
          dio: Get.find(),
          dao: Get.find<AppDatabase>().grupoDefeitoEquipamentoDao,
        ));

    Get.lazyPut<SubgrupoDefeitoRepository>(() => SubgrupoDefeitoRepositoryImpl(
          dio: Get.find(),
          dao: Get.find<AppDatabase>().subgrupoDefeitoEquipamentoDao,
        ));

    // Serviços de sincronização
    Get.lazyPut(() => EquipamentoSyncService(Get.find()));
    Get.lazyPut(() => TipoAtividadeSyncService(Get.find()));
    Get.lazyPut(() => GrupoDefeitoSyncService(Get.find()));
    Get.lazyPut(() => SubgrupoDefeitoSyncService(Get.find()));

    // Orquestrador
    Get.lazyPut(() => SyncOrchestratorService(
          tipoAtividadeSyncService: Get.find(),
          equipamentoSyncService: Get.find(),
          grupoDefeitoSyncService: Get.find(),
          subgrupoDefeitoSyncService: Get.find(),
        ));
  }
}
