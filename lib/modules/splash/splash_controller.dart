import 'package:get/get.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class SplashController extends GetxController {
  final status = ''.obs;
  final carregando = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _verificarSessao(); // 2. só então usa
  }

  Future<void> _verificarSessao() async {
    final session = Get.find<SessionManager>();
    await session.init();

    if (session.estaLogado) {
      await _sincronizarDados();
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }

  Future<void> _sincronizarDados() async {
    status.value = 'Sincronizando dados...';
    await Future.delayed(const Duration(milliseconds: 500));
    // você pode adicionar syncs reais aqui
  }
}
