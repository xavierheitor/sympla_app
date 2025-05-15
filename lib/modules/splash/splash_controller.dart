import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';
import 'package:sympla_app/core/sync/sync_manager.dart';

class SplashController extends GetxController {
  final carregando = true.obs;

  final SyncManager syncManager;

  SplashController({required this.syncManager});

  @override
  Future<void> onInit() async {
    super.onInit();
    AppLogger.d('🌀 Splash: onInit iniciado');

    final session = Get.find<SessionManager>();
    await session.init();

    AppLogger.d('🌀 Após init. Usuario: ${session.usuario}');

    if (!session.estaLogado) {
      AppLogger.w('🔐 Nenhum usuário logado. Indo para login.');
      Get.offAllNamed(Routes.login);
      return;
    }

    AppLogger.i('🔐 Sessão válida encontrada. Iniciando sincronização...');

    try {
      final resultado = await syncManager.sincronizarTudo();
      if (!resultado.podeContinuar) {
        AppLogger.e(
            '🚫 Sincronização falhou e não há dados locais suficientes');
        Get.offAllNamed(Routes.erroSplash);
        return;
      }
    } catch (e) {
      AppLogger.e('❌ Erro inesperado durante sincronização: $e');
      Get.offAllNamed(Routes.erroSplash);
      return;
    }

    AppLogger.d('🌀 Sincronização concluída. Indo para Home...');
    Get.offAllNamed(Routes.home);
  }
}
