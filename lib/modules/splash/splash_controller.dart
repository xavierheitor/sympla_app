import 'dart:io';

import 'package:get/get.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/services/sync/sync_orchestrator_service.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class SplashController extends GetxController {
  final status = ''.obs;
  final carregando = true.obs;

  final syncService = Get.find<SyncOrchestratorService>();

  @override
  Future<void> onInit() async {
    super.onInit();

    AppLogger.d('🌀 Splash: onInit iniciado');

    final session = Get.find<SessionManager>();
    await session.init(); // ← importante para garantir usuário

    AppLogger.d('🌀 Após init. Usuario: ${session.usuario}');

    await _sincronizarDados();

    AppLogger.d('🌀 Após sincronização. Verificando sessão...');

    await _verificarSessao(); // ← redireciona só após sincronização
  }

  Future<void> _verificarSessao() async {
    final session = Get.find<SessionManager>();

    AppLogger.d('🔐 estaLogado = ${session.estaLogado}');

    if (session.estaLogado) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }

  Future<void> _sincronizarDados() async {
    final temRede = await _verificarConexao();

    if (!temRede) {
      AppLogger.w('Sem conexão com a internet. Pulando sincronização.',
          tag: 'Splash');
      return;
    }

    // Simulação ou sync real
    status.value = 'Sincronizando dados...';
    // await Future.delayed(const Duration(seconds: 3));

    await syncService.sincronizarTudo();

    AppLogger.i('Sincronização finalizada com sucesso', tag: 'Splash');
  }

  Future<bool> _verificarConexao() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
