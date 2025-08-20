import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/core_app/services/atividade_etapa_service.dart';
import 'package:sympla_app/core/core_app/services/atividade_service.dart';
import 'package:sympla_app/core/core_app/services/auth_service.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/anomalia_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/apr_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/checklist_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/mpbb_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/mpdj_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/usuario_repository.dart';
import 'package:sympla_app/core/domain/repositories/implementations/anomalia_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/apr_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/atividade_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/checklist_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/mpbb_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/mpdj_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/usuario_repository_impl.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/upload/background_sync_service.dart';
import 'package:sympla_app/core/upload/upload_manager.dart';
import 'package:sympla_app/core/upload/upload_service.dart';

/// Registro global de dependências do app.
///
/// - Inicializa serviços core (DB, HTTP, SESSÃO)
/// - Registra repositórios e serviços de DOMÍNIO
/// - Prepara serviços de upload/sincronização em background
class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // === Core (DB, API) ===
    // Banco local (Drift) e cliente HTTP (Dio)
    Get.put(AppDatabase(), permanent: true);
    Get.put(DioClient(Get.find()), permanent: true);

    // === Repositórios ===
    Get.lazyPut<UsuarioRepository>(
      () => UsuarioRepositoryImpl(Get.find(), Get.find()),
      fenix: true,
    );
    Get.lazyPut<AtividadeRepository>(
      () => AtividadeRepositoryImpl(Get.find(), Get.find()),
      fenix: true,
    );
    Get.lazyPut<ChecklistRepository>(
      () => ChecklistRepositoryImpl(Get.find(), Get.find()),
      fenix: true,
    );
    Get.lazyPut<AprRepository>(
      () => AprRepositoryImpl(Get.find(), Get.find()),
      fenix: true,
    );
    Get.lazyPut<AnomaliaRepository>(
      () => AnomaliaRepositoryImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut<MpDjRepository>(
      () => MpdjRepositoryImpl(Get.find(), Get.find()),
      fenix: true,
    );
    Get.lazyPut<MpbbRepository>(
      () => MpbbRepositoryImpl(Get.find(), Get.find()),
      fenix: true,
    );

    // === Serviços ===
    // Autenticação, regras de atividade e orquestração de etapas
    Get.lazyPut(() => AuthService(Get.find()), fenix: true);
    Get.lazyPut(() => AtividadeService(Get.find()), fenix: true);
    Get.lazyPut(() => AtividadeEtapaService(Get.find()), fenix: true);

    // === Upload Services ===
    // Montagem e envio de dados de atividades
    Get.lazyPut(
        () => UploadService(
              atividadeRepository: Get.find(),
              checklistRepository: Get.find(),
              aprRepository: Get.find(),
              anomaliaRepository: Get.find(),
              mpdjRepository: Get.find(),
              mpbbRepository: Get.find(),
            ),
        fenix: true);

    Get.lazyPut(
        () => UploadManager(
              dio: Get.find(),
              atividadeRepo: Get.find(),
              uploadService: Get.find(),
            ),
        fenix: true);

    // === Background Sync Service ===
    // Verificação periódica e escoamento da fila de upload
    Get.lazyPut(
        () => BackgroundSyncService(
              atividadeRepository: Get.find(),
              uploadManager: Get.find(),
            ),
        fenix: true);

    // === Sessão ===
    // Gerencia o usuário logado, token e refresh
    Get.put(SessionManager(authService: Get.find()), permanent: true);

    // === Atividade Controller ===
    // Estado global de atividades disponíveis e em andamento
    Get.put(AtividadeController(Get.find(), Get.find()), permanent: true);
  }
}
