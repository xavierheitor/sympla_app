import 'package:get/get.dart';
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
    AppLogger.i("Iniciando login...", tag: "Login");
    carregando.value = true;
    erro.value = '';

    try {
      await authService.login(matricula.value, senha.value);
      AppLogger.i("Login realizado com sucesso", tag: "Login");

      // TODO: Navegar para tela principal após login
    } catch (e, stack) {
      AppLogger.e("Erro ao realizar login",
          tag: "Login", error: e, stackTrace: stack);
      erro.value = 'Não foi possível realizar o login.';
    } finally {
      carregando.value = false;
    }
  }
}
