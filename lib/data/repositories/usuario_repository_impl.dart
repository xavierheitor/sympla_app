import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/domain/repositories/usuario_repository.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final AppDatabase db;

  UsuarioRepositoryImpl(this.db);

  @override
  Future<UsuarioTableData?> buscarPorMatricula(String matricula) {
    return (db.select(db.usuarioTable)
          ..where((tbl) => tbl.matricula.equals(matricula)))
        .getSingleOrNull();
  }

  @override
  Future<void> salvarUsuario(UsuarioTableCompanion usuario) {
    return db.into(db.usuarioTable).insertOnConflictUpdate(usuario);
  }
}
