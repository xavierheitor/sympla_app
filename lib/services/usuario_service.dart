import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/domain/repositories/usuario_repository.dart';

class UsuarioService {
  final UsuarioRepository repository;

  UsuarioService(this.repository);

  Future<UsuarioTableData?> login(String matricula) async {
    final usuario = await repository.buscarPorMatricula(matricula);
    if (usuario == null) {
      throw Exception("Usuário não encontrado");
    }
    return usuario;
  }

  Future<void> salvar(UsuarioTableCompanion usuario) {
    return repository.salvarUsuario(usuario);
  }
}
