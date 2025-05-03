import 'package:get/get.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/storage/app_database.dart';

import 'package:sympla_app/core/data/repositories/auth_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/usuario_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/auth_repository.dart';
import 'package:sympla_app/core/domain/repositories/usuario_repository.dart';

import 'package:sympla_app/modules/login/auth_service.dart';

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

    // Core ervices
    Get.put(AuthService(Get.find(), Get.find()), permanent: true);
    Get.put(SessionManager(Get.find(), db: Get.find(), authService: Get.find()),
        permanent: true);

    // futuros services adicione aqui
  }
}
