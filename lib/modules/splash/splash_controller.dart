import 'package:get/get.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class SplashController extends GetxController {
  final status = ''.obs;
  final carregando = true.obs;

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
    status.value = 'Sincronizando dados...';

    // Simulação de delay para sincronização real
    await Future.delayed(const Duration(seconds: 3));

    AppLogger.i('Sincronização finalizada', tag: 'Splash');
    // você pode adicionar syncs reais aqui
  }
}
