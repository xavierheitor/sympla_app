import 'package:get/get.dart';
import 'package:sympla_app/core/helpers/error_helper.dart';
import 'package:sympla_app/services/auth_service.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class LoginController extends GetxController {
  final AuthService authService;

  final matricula = ''.obs;
  final senha = ''.obs;
  final carregando = false.obs;
  final erro = ''.obs;

  LoginController(this.authService);

  Future<void> login() async {
    carregando.value = true;
    erro.value = '';

    try {
      AppLogger.i("Iniciando login...", tag: "Login");

      await authService.login(matricula.value, senha.value);

      AppLogger.i("Login realizado com sucesso", tag: "Login");
      Get.offAllNamed('/splash');
    } catch (e, stack) {
      AppLogger.e("Erro ao realizar login",
          tag: "Login", error: e, stackTrace: stack);

      // Preenche o erro de forma amigável
      erro.value = ErrorHelper.getUserMessage(e);
    } finally {
      carregando.value = false;
    }
  }
}
