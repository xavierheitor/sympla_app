import 'package:get/get.dart';
import 'package:sympla_app/services/usuario_service.dart';

class LoginController extends GetxController {
  final UsuarioService service;
  final matricula = ''.obs;
  final carregando = false.obs;

  LoginController(this.service);

  Future<void> login() async {
    try {
      carregando.value = true;
      final usuario = await service.login(matricula.value);
      // Aqui você pode navegar ou salvar na sessão
      print("Login OK: ${usuario?.nome}");
    } catch (e) {
      print("Erro: $e");
    } finally {
      carregando.value = false;
    }
  }
}
