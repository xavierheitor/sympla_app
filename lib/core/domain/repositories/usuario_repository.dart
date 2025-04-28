import 'package:sympla_app/core/storage/app_database.dart';

abstract class UsuarioRepository {
  Future<UsuarioTableData?> buscarPorMatricula(String matricula);
  Future<void> salvarUsuario(UsuarioTableCompanion usuario);
}
