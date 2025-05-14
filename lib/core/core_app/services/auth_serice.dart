import 'package:sympla_app/core/domain/repositories/abstracts/usuario_repository.dart';

class AuthService {
  final UsuarioRepository usuarioRepository;

  AuthService(this.usuarioRepository);

  getUsuarios() {}

  logout() {}

  refresh(String refreshToken) {}

  login(String email, String password) {}
}
