import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';
import 'package:sympla_app/core/sync/sync_manager.dart';

class HomeController extends GetxController {
  // Session manager
  final SessionManager session;

  // Atividade controller
  final AtividadeController atividadeController;

  // Contructor
  HomeController(this.session, this.atividadeController);

  // nome do usuario
  String get nomeUsuario => session.usuario?.nome ?? 'Usuário';

  // bool sincronizacao
  final RxBool sincronizacao = false.obs;

  //garante atividades sempre atualizadas na tela home
  @override
  void onReady() {
    super.onReady();
    atividadeController.carregarAtividades(); // garante atualização ao voltar
  }

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

  // Metodo de sincronizar atividades
  void sincronizarAtividades() async {
    sincronizacao.value = true;
    await Get.find<SyncManager>().sincronizarModulo('atividade', force: true);
    sincronizacao.value = false;
  }

  // Metodo de forçar sincronizacao completa
  void sincronizarTudo() async {
    sincronizacao.value = true;
    await Get.find<SyncManager>().sincronizarTudo(force: true);
    sincronizacao.value = false;
  }
}
