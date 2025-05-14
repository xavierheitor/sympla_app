import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/services/auth_serice.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/usuario_repository.dart';
import 'package:sympla_app/core/domain/repositories/implementations/usuario_repository_impl.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Core resources
    Get.put(AppDatabase(), permanent: true);
    Get.put(DioClient(), permanent: true);

    // repositories
    Get.lazyPut<UsuarioRepository>(
        () => UsuarioRepositoryImpl(
              Get.find(),
              Get.find(),
            ),
        fenix: true);

    // Core ervices
    Get.lazyPut(() => AuthService(Get.find()), fenix: true);

    Get.put(SessionManager(authService: Get.find()), permanent: true);

    // futuros services adicione aqui
  }
}
