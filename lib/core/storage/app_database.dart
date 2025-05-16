// ignore_for_file: override_on_non_overriding_member, unused_import

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:sympla_app/core/constants/tipo_atividade_mobile.dart';

import 'package:sympla_app/core/storage/converters/caracterizacao_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/core/storage/converters/lado_converter.dart';
import 'package:sympla_app/core/storage/converters/posicao_disjuntor_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/prioridade_defeito_converter.dart';
import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_bateria_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_extinsao_disjutnor_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_atividade_mobile_converter.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';

import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/daos/anomalia_dao.dart';
import 'package:sympla_app/core/storage/daos/apr_dao.dart';
import 'package:sympla_app/core/storage/daos/atividade_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist_dao.dart';
import 'package:sympla_app/core/storage/daos/defeito_dao.dart';
import 'package:sympla_app/core/storage/daos/equipamento_dao.dart';
import 'package:sympla_app/core/storage/daos/mpbb_ddao.dart';
import 'package:sympla_app/core/storage/daos/mpdj_dao.dart';
import 'package:sympla_app/core/storage/daos/tecnico_dao.dart';
import 'package:sympla_app/core/storage/daos/usuario_dao.dart';
import 'package:sympla_app/core/storage/logging_executor.dart';

import 'dart:io';

import 'package:sympla_app/core/storage/tables/schema.dart';

// ignore: uri_does_not_exist
part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sympla4.sqlite'));

    final nativeDb = NativeDatabase(
      file,
      // logStatements: true,
    );
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
    DefeitoTable,
    AnomaliaTable,
    CorrecaoAnomaliaTable,
    ChecklistTable,
    ChecklistPerguntaTable,
    ChecklistPerguntaRelacionamentoTable,
    ChecklistPreenchidoTable,
    ChecklistRespostaTable,
    GrupoDefeitoCodigoTable,
    FormularioBateriaTable,
    MedicaoElementoBateriaTable,
    PrevDisjForm,
    MedicaoPressaoSf6Table,
    MedicaoResistenciaContatoTable,
    MedicaoResistenciaIsolamentoTable,
    MedicaoTempoOperacaoTable,
    TecnicoTable,
    AprTable,
    AprQuestionTable,
    AprPerguntaRelacionamentoTable,
    AprPreenchidaTable,
    AprRespostaTable,
    AprAssinaturaTable,
  ],
  daos: [
    UsuarioDao,
    AtividadeDao,
    EquipamentoDao,
    DefeitoDao,
    AprDao,
    ChecklistDao,
    MpbbDao,
    MpdjDao,
    TecnicoDao,
    AnomaliaDao,
  ],
)
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
