// ignore_for_file: override_on_non_overriding_member

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sympla_app/core/storage/daos/usuario_dao.dart';
import 'dart:io';

import 'package:sympla_app/core/storage/tables/usuario_table.dart';

// ignore: uri_does_not_exist
part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sympla.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [
    UsuarioTable,
  ],
  daos: [
    UsuarioDao,
  ],
) // ← você vai adicionar as tabelas aqui
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            // exemplo: await m.addColumn(usuarioTable, usuarioTable.novoCampo);
          }

          // versões futuras aqui
        },
        beforeOpen: (details) async {
          // Você pode fazer verificação, popular tabelas, logs, etc.
          if (details.wasCreated) {
            // Seed inicial se necessário
          }
        },
      );
}
