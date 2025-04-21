import 'package:get/get.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/services/auth_service.dart';

class SplashController extends GetxController {
  final status = ''.obs;
  final carregando = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _inicializarSessao(); // 1. garante a injeção
    await _verificarSessao(); // 2. só então usa
  }

  Future<void> _inicializarSessao() async {
    if (!Get.isRegistered<SessionManager>()) {
      final db = Get.find<AppDatabase>();
      final auth = Get.find<AuthService>();

      await Get.putAsync<SessionManager>(() async {
        return await SessionManager(db: db, authService: auth).init();
      });

      AppLogger.i('SessionManager registrado e inicializado', tag: 'Splash');
    }
  }

  Future<void> _verificarSessao() async {
    final session = Get.find<SessionManager>(); // <- agora seguro

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
