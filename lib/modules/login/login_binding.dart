import 'package:get/get.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/modules/login/login_controller.dart';
import 'package:sympla_app/services/usuario_service.dart';
import 'package:sympla_app/data/repositories/usuario_repository_impl.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    final db = Get.find<AppDatabase>();

    Get.lazyPut(() => UsuarioRepositoryImpl(db));
    Get.lazyPut(() => UsuarioService(Get.find()));
    Get.lazyPut(() => LoginController(Get.find()));
  }
}
