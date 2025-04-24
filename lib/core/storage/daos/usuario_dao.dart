import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/tables/usuario_table.dart';
import 'package:sympla_app/core/storage/app_database.dart';

part 'usuario_dao.g.dart';

@DriftAccessor(tables: [UsuarioTable])
class UsuarioDao extends DatabaseAccessor<AppDatabase> with _$UsuarioDaoMixin {
  final AppDatabase db;

  UsuarioDao(this.db) : super(db);

  Future<List<UsuarioTableData>> getAllUsuarios() => select(usuarioTable).get();

  Stream<List<UsuarioTableData>> watchAllUsuarios() =>
      select(usuarioTable).watch();
  Future insertUsuario(UsuarioTableCompanion usuario) =>
      into(usuarioTable).insert(usuario);
  Future deleteUsuario(int id) =>
      (delete(usuarioTable)..where((tbl) => tbl.id.equals(id))).go();

  // ✅ Novo método
  Future<bool> limparUsuarios() async {
    try {
      await delete(usuarioTable).go();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UsuarioTableData?> buscarPorMatricula(String matricula) {
    return (select(usuarioTable)..where((u) => u.matricula.equals(matricula)))
        .getSingleOrNull();
  }

  Future<int> salvarUsuario(UsuarioTableCompanion usuario) {
    return into(usuarioTable).insertOnConflictUpdate(usuario);
  }
}
