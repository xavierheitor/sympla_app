import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/domain/repositories/auth_repository.dart';
import 'package:sympla_app/domain/repositories/usuario_repository.dart';

class AuthService {
  final AuthRepository authRepository;
  final UsuarioRepository usuarioRepository;

  AuthService(this.authRepository, this.usuarioRepository);

  Future<void> login(String matricula, String senha) async {
    final response = await authRepository.login(matricula, senha);

    final usuario = UsuarioTableCompanion(
      nome: Value(response.nome),
      matricula: Value(matricula),
      token: Value(response.token),
      refreshToken: Value(response.refreshToken),
      ultimoLogin: Value(DateTime.now()),
    );

    await usuarioRepository.salvarUsuario(usuario);
  }

  Future<void> refresh(String token) async {
    final response = await authRepository.refreshToken(token);

    final usuario = UsuarioTableCompanion(
      token: Value(response.token),
      refreshToken: Value(response.refreshToken),
      ultimoLogin: Value(DateTime.now()),
    );

    await usuarioRepository.salvarUsuario(usuario);
  }
}
