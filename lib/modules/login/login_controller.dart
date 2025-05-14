import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/services/auth_serice.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
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
      final erro = ErrorHandler.tratar(e, stack);
      AppLogger.e("Erro ao realizar login",
          tag: "LoginController - login", error: e, stackTrace: stack);

      // Preenche o erro de forma amigável
      final mensagem = ErrorHandler.mensagemUsuario(erro);

      Get.snackbar(mensagem.titulo, mensagem.descricao,
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      carregando.value = false;
    }
  }
}
