import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/core_app/services/atividade_etapa_service.dart';
import 'package:sympla_app/core/core_app/services/atividade_service.dart';
import 'package:sympla_app/core/core_app/services/auth_service.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/usuario_repository.dart';
import 'package:sympla_app/core/domain/repositories/implementations/atividade_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/usuario_repository_impl.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';
import 'package:sympla_app/core/storage/app_database.dart';
class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // === Core (DB, API) ===
    Get.put(AppDatabase(), permanent: true);
    Get.put(DioClient(), permanent: true);

    // === Repositórios ===
    Get.lazyPut<UsuarioRepository>(
      () => UsuarioRepositoryImpl(Get.find(), Get.find()),
      fenix: true,
    );
    Get.lazyPut<AtividadeRepository>(
      () => AtividadeRepositoryImpl(Get.find(), Get.find()),
      fenix: true,
    );

    // === Serviços ===
    Get.lazyPut(() => AuthService(Get.find()), fenix: true);
    Get.lazyPut(() => AtividadeService(Get.find()), fenix: true);
    Get.lazyPut(() => AtividadeEtapaService(Get.find()), fenix: true);

    // === Sessão ===
    Get.put(SessionManager(authService: Get.find()), permanent: true);

    // === Atividade Controller ===
    Get.put(AtividadeController(Get.find(), Get.find()), permanent: true);
  }
}
