import 'package:get/get.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/modules/login/login_controller.dart';
import 'package:sympla_app/data/repositories/auth_repository_impl.dart';
import 'package:sympla_app/data/repositories/usuario_repository_impl.dart';
import 'package:sympla_app/core/services/auth_service.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    final db = Get.find<AppDatabase>();
    final dio = Get.find<DioClient>(); // ← pegando do centralizador

    Get.lazyPut(() => UsuarioRepositoryImpl(db));
    Get.lazyPut(() => AuthRepositoryImpl(dio));
    Get.lazyPut(() => AuthService(Get.find(), Get.find()));
    Get.lazyPut(() => LoginController(Get.find()));
  }
}
