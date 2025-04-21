import 'package:get/get.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/data/repositories/auth_repository_impl.dart';
import 'package:sympla_app/data/repositories/usuario_repository_impl.dart';
import 'package:sympla_app/services/auth_service.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppDatabase(), fenix: true);
    Get.lazyPut(() => DioClient(), fenix: true);

    // Repositórios base
    Get.lazyPut(() => UsuarioRepositoryImpl(Get.find()));
    Get.lazyPut(() => AuthRepositoryImpl(Get.find<DioClient>().dio));
    Get.lazyPut(() => AuthService(Get.find(), Get.find()));

    // Inicializa a sessão de forma assíncrona
    Get.putAsync<SessionManager>(() async {
      final db = Get.find<AppDatabase>();
      final authService = Get.find<AuthService>();
      return await SessionManager(db: db, authService: authService).init();
    });
  }
}
