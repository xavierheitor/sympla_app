import 'package:get/get.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class HomeController extends GetxController {
  final session = Get.find<SessionManager>();

  String get nomeUsuario => session.usuario?.nome ?? 'Usuário';

  Future<void> sair() async {
    await session.logout();
    Get.offAllNamed('/login');
  }
}
