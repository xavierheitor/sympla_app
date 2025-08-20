import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/sync/sync_manager.dart';

/// Controla o fluxo de inicialização do app.
///
/// Passos principais durante o `onInit`:
/// 1) Inicializa a sessão (carrega usuário local e tenta renovar token)
/// 2) Se não há sessão válida, navega para `Routes.login`
/// 3) Com sessão válida, dispara a sincronização inicial (`SyncManager`)
/// 4) Em caso de sucesso (ou dados locais suficientes), segue para Home
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
      await Get.offAllNamed(Routes.login);
      return;
    }

    AppLogger.i('🔐 Sessão válida encontrada. Iniciando sincronização...');

    try {
      final resultado = await syncManager.sincronizarTudo();
      if (!resultado.podeContinuar) {
        AppLogger.e(
            '🚫 Sincronização falhou e não há dados locais suficientes');
        await Get.offAllNamed(Routes.erroSplash);
        return;
      }
    } catch (e) {
      AppLogger.e('❌ Erro inesperado durante sincronização: $e');
      await Get.offAllNamed(Routes.erroSplash);
      return;
    }

    AppLogger.d('🌀 Sincronização concluída. Indo para Home...');
    await Get.offAllNamed(Routes.home);
  }
}
