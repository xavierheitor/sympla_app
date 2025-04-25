import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/services/sync/atividade_sync_service.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class HomeController extends GetxController {
  final SessionManager session;
  final AtividadeSyncService atividadeSyncService;

  final RxList<AtividadeTableData> atividades = <AtividadeTableData>[].obs;
  final RxBool isLoading = false.obs;

  HomeController(this.session, this.atividadeSyncService);

  @override
  Future<void> onInit() async {
    super.onInit();

    if (await atividadeSyncService.estaVazio()) {
      try {
        isLoading.value = true;
        await atividadeSyncService.sincronizar();
        await buscarAtividades();
      } catch (e, s) {
        final erro = ErrorHandler.tratar(e, s);
        AppLogger.e('[HomeController - onInit] ${erro.mensagem}',
            tag: 'HomeController', error: e, stackTrace: s);
        Get.snackbar('Erro', 'Erro ao sincronizar atividades',
            backgroundColor: Colors.red, colorText: Colors.white);
      } finally {
        isLoading.value = false;
      }
    }
  }

  String get nomeUsuario => session.usuario?.nome ?? 'Usuário';

  Future<void> sair() async {
    AppLogger.i('Saindo...', tag: 'HomeController');
    final result = await session.logout();
    if (result) {
      Get.offAllNamed('/login');
    } else {
      AppLogger.e('Erro ao deslogar', tag: 'HomeController');
      Get.snackbar('Erro', 'Erro ao sair',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> buscarAtividades() async {
    try {
      isLoading.value = true;
      final lista = await atividadeSyncService.buscarTodas();
      atividades.assignAll(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[HomeController - buscarAtividades] ${erro.mensagem}',
          tag: 'HomeController', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao buscar atividades',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
