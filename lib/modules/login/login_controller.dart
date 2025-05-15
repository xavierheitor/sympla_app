import 'package:get/get.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:sympla_app/modules/login/login_service.dart';

class LoginController extends GetxController {
  final LoginService loginService;

  final matricula = ''.obs;
  final senha = ''.obs;
  final carregando = false.obs;
  final erro = ''.obs;

  LoginController(this.loginService);

  Future<void> login() async {
    carregando.value = true;
    erro.value = '';

    try {
      await loginService.login(matricula.value, senha.value);
      Get.offAllNamed('/splash');
    } catch (e, s) {
      final trat = ErrorHandler.tratar(e, s);
      erro.value = trat.mensagem;
      Get.snackbar(
        'Erro ao realizar login',
        trat.mensagem,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      carregando.value = false;
    }
  }
}
