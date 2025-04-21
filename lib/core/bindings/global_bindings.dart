import 'package:get/get.dart';
import 'package:sympla_app/core/network/dio_client.dart';
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
    // Inicializa banco e Dio
    Get.lazyPut<AppDatabase>(() => AppDatabase(), fenix: true);
    Get.lazyPut<DioClient>(() => DioClient(), fenix: true);

    // Repositórios
    Get.lazyPut<UsuarioRepository>(
        () => UsuarioRepositoryImpl(Get.find<AppDatabase>()));
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find<DioClient>().dio));

    // Services
    Get.lazyPut<AuthService>(() => AuthService(Get.find(), Get.find()));
  }
}
