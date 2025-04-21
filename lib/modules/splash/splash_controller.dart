import 'package:get/get.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class SplashController extends GetxController {
  final status = ''.obs;
  final carregando = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _verificarSessao();
  }

  Future<void> _verificarSessao() async {
    final session = Get.find<SessionManager>();

    if (session.estaLogado) {
      await _sincronizarDados();
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }

  Future<void> _sincronizarDados() async {
    try {
      status.value = 'Sincronizando técnicos...';
      await Future.delayed(const Duration(milliseconds: 500));
      // await tecnicoService.sync();

      status.value = 'Sincronizando atividades...';
      await Future.delayed(const Duration(milliseconds: 500));
      // await atividadeService.sync();

      status.value = 'Sincronizando checklists...';
      await Future.delayed(const Duration(milliseconds: 500));
      // await checklistService.sync();

      // Adicione os syncs reais aqui

      AppLogger.i('Sincronização finalizada com sucesso', tag: 'Splash');
    } catch (e, stack) {
      AppLogger.e('Erro durante sincronização',
          tag: 'Splash', error: e, stackTrace: stack);
      // Pode adicionar Get.snackbar() ou algo semelhante
    }
  }
}
