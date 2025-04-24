// ignore_for_file: override_on_non_overriding_member

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/daos/atividade_dao.dart';
import 'package:sympla_app/core/storage/daos/equipamento_dao.dart';
import 'package:sympla_app/core/storage/daos/grupo_defeito_equipamento_dao.dart';
import 'package:sympla_app/core/storage/daos/subgrupo_defeito_equipamento_dao.dart';
import 'package:sympla_app/core/storage/daos/tipo_atividade_dao.dart';
import 'package:sympla_app/core/storage/daos/usuario_dao.dart';
import 'package:sympla_app/core/storage/logging_executor.dart';
import 'package:sympla_app/core/storage/tables/atividade_table.dart';
import 'package:sympla_app/core/storage/tables/equipamento_table.dart';
import 'package:sympla_app/core/storage/tables/grupo_defeito_equipamento.dart';
import 'package:sympla_app/core/storage/tables/subgrupo_defeito_equipamento.dart';
import 'package:sympla_app/core/storage/tables/tipo_atividade_table.dart';
import 'package:sympla_app/core/storage/tables/usuario_table.dart';
import 'dart:io';

import 'package:sympla_app/core/storage/converters/tipo_atividade_mobile_converter.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';

// ignore: uri_does_not_exist
part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sympla.sqlite'));

    final nativeDb = NativeDatabase(file, logStatements: true);
    return LoggingExecutor(nativeDb);
  });
}

@DriftDatabase(
  tables: [
    UsuarioTable,
    TipoAtividadeTable,
    AtividadeTable,
    EquipamentoTable,
    GrupoDefeitoEquipamentoTable,
    SubgrupoDefeitoEquipamentoTable,
  ],
  daos: [
    UsuarioDao,
    TipoAtividadeDao,
    AtividadeDao,
    EquipamentoDao,
    GrupoDefeitoEquipamentoDao,
    SubgrupoDefeitoEquipamentoDao,
  ],
) // ← você vai adicionar as tabelas aqui
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection()) {
    AppLogger.d('🗃️ AppDatabase iniciado');
  }

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
