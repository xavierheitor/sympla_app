import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'generated/usuario_dao.g.dart';

@DriftAccessor(tables: [UsuarioTable])
class UsuarioDao extends DatabaseAccessor<AppDatabase> with _$UsuarioDaoMixin {
  final AppDatabase db;

  UsuarioDao(this.db) : super(db);

  /// Busca todos os usuários armazenados localmente.
  Future<List<UsuarioTableData>> buscarTodos() => select(usuarioTable).get();

  /// Observa todos os usuários em tempo real.
  Stream<List<UsuarioTableData>> observarTodos() =>
      select(usuarioTable).watch();

  /// Insere ou atualiza um usuário com base na chave primária ou `unique`.
  Future<int> salvar(UsuarioTableCompanion usuario) async {
    final existente = await buscarPorMatricula(usuario.matricula.value);
    if (existente != null) {
      return (update(usuarioTable)
            ..where((u) => u.matricula.equals(usuario.matricula.value)))
          .write(usuario);
    } else {
      return into(usuarioTable).insert(usuario);
    }
  }
  /// Deleta um usuário com base no ID.
  Future<int> deletarPorId(String id) =>
      (delete(usuarioTable)..where((u) => u.uuid.equals(id))).go();

  /// Limpa todos os registros da tabela de usuários.
  Future<void> limparTodos() async {
    await delete(usuarioTable).go();
  }

  /// Busca um usuário pela matrícula.
  Future<UsuarioTableData?> buscarPorMatricula(String matricula) {
    return (select(usuarioTable)..where((u) => u.matricula.equals(matricula)))
        .getSingleOrNull();
  }
}
