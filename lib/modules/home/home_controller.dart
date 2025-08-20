import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/sync/sync_manager.dart';

/// Controlador da tela Home.
///
/// - Expõe nome do usuário logado
/// - Orquestra sincronização manual (módulo "atividade" ou total)
/// - Garante atualização da lista de atividades ao retornar para a Home
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

  // Garante atividades sempre atualizadas na tela home
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
      await Get.offAllNamed(Routes.login);
    } else {
      AppLogger.e('Erro ao deslogar', tag: 'HomeController');
      Get.snackbar('Erro', 'Erro ao sair',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Sincroniza apenas o módulo de atividades (pull da API)
  void sincronizarAtividades() {
    sincronizacao.value = true;
    // Executar em background
    Future.microtask(() async {
      try {
        await Get.find<SyncManager>().sincronizarModulo('atividade', force: true);
        AppLogger.d('✅ Sincronização de atividades concluída');
      } catch (e, s) {
        AppLogger.e('❌ Erro na sincronização de atividades', error: e, stackTrace: s);
      } finally {
        sincronizacao.value = false;
      }
    });
  }

  // Força sincronização completa de todos os módulos registrados
  void sincronizarTudo() {
    sincronizacao.value = true;
    // Executar em background
    Future.microtask(() async {
      try {
        await Get.find<SyncManager>().sincronizarTudo(force: true);
        AppLogger.d('✅ Sincronização completa concluída');
      } catch (e, s) {
        AppLogger.e('❌ Erro na sincronização completa', error: e, stackTrace: s);
      } finally {
        sincronizacao.value = false;
      }
    });
  }
}
