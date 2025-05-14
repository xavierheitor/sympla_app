import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class HomeController extends GetxController {
  final SessionManager session;
  final AtividadeController atividadeController;

  HomeController(this.session, this.atividadeController);

  String get nomeUsuario => session.usuario?.nome ?? 'Usuário';

  // metodo de logout
  Future<void> sair() async {
    AppLogger.i('Saindo...', tag: 'HomeController');
    final result = await session.logout();
    if (result) {
      Get.offAllNamed(Routes.login);
    } else {
      AppLogger.e('Erro ao deslogar', tag: 'HomeController');
      Get.snackbar('Erro', 'Erro ao sair',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

//garante atividades sempre atualizadas na tela home
  @override
  void onReady() {
    super.onReady();
    atividadeController.carregarAtividades(); // garante atualização ao voltar
  }

  //sincroniza apenas as atividades, caso seja atribuida uma nova atividade para o tecnico
  void sincronizarAtividades() {
    atividadeController.sincronizarAtividades();
  }
}
