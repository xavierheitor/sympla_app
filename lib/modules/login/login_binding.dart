import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/services/auth_service.dart';
import 'package:sympla_app/modules/login/login_service.dart';
import 'package:sympla_app/modules/login/login_controller.dart';

/// Binding da tela de Login.
///
/// Registra `LoginService` e `LoginController` específicos da tela.
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Apenas o que é exclusivo da tela de login
    Get.lazyPut<LoginService>(() => LoginService(Get.find<AuthService>()));
    Get.lazyPut<LoginController>(
        () => LoginController(Get.find<LoginService>()));
  }
}
