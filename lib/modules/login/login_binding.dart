import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/services/auth_serice.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/usuario_repository.dart';
import 'package:sympla_app/core/domain/repositories/implementations/usuario_repository_impl.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsuarioRepository>(() => UsuarioRepositoryImpl(
          Get.find(),
          Get.find(),
        ));
    Get.lazyPut<AuthService>(() => AuthService(
          Get.find(),
        ));
  }
}
