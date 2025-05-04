// ignore_for_file: override_on_non_overriding_member

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sympla_app/core/constants/tipo_atividade_mobile.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/converters/caracterizacao_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/core/storage/converters/lado_converter.dart';
import 'package:sympla_app/core/storage/converters/posicao_disjuntor_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_bateria_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_extinsao_disjutnor_converter.dart';
import 'package:sympla_app/core/storage/daos/apr/apr_assinatura_dao.dart';
import 'package:sympla_app/core/storage/daos/apr/apr_dao.dart';
import 'package:sympla_app/core/storage/daos/apr/apr_pergunta_dao.dart';
import 'package:sympla_app/core/storage/daos/apr/apr_pergunta_relacionamento_dao.dart';
import 'package:sympla_app/core/storage/daos/apr/apr_preenchida_dao.dart';
import 'package:sympla_app/core/storage/daos/apr/apr_resposta_dao.dart';
import 'package:sympla_app/core/storage/daos/atividade/atividade_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist/anomalia_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_grupo_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_pergunta_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_pergunta_relacionamento_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_resposta_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_subgrupo_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist/correcao_anomalia_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist/defeito_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist/grupo_defeito_equipamento_dao.dart';
import 'package:sympla_app/core/storage/daos/checklist/subgrupo_defeito_equipamento_dao.dart';
import 'package:sympla_app/core/storage/daos/grupos_defeito/equipamento_dao.dart';
import 'package:sympla_app/core/storage/daos/mp_bb/formulario_bateria_dao.dart';
import 'package:sympla_app/core/storage/daos/mp_bb/medicao_elemento_bateria_dao.dart';
import 'package:sympla_app/core/storage/daos/mp_dj/medicao_pressao_sf6_dao.dart';
import 'package:sympla_app/core/storage/daos/mp_dj/medicao_resistencia_contato_dao.dart';
import 'package:sympla_app/core/storage/daos/mp_dj/medicao_resistencia_isolamento_dao.dart';
import 'package:sympla_app/core/storage/daos/mp_dj/medicao_tempo_operacao_dao.dart';
import 'package:sympla_app/core/storage/daos/mp_dj/prev_disj_form_dao.dart';
import 'package:sympla_app/core/storage/daos/tecnicos_dao.dart';
import 'package:sympla_app/core/storage/daos/atividade/tipo_atividade_dao.dart';
import 'package:sympla_app/core/storage/daos/usuario_dao.dart';
import 'package:sympla_app/core/storage/logging_executor.dart';
import 'package:sympla_app/core/storage/tables/apr/apr_assinatura_table.dart';
import 'package:sympla_app/core/storage/tables/apr/apr_pergunta_relacionamento_table.dart';
import 'package:sympla_app/core/storage/tables/apr/apr_preenchida_table.dart';
import 'package:sympla_app/core/storage/tables/apr/apr_question_table.dart';
import 'package:sympla_app/core/storage/tables/apr/apr_resposta_table.dart';
import 'package:sympla_app/core/storage/tables/apr/apr_table.dart';
import 'package:sympla_app/core/storage/tables/atividade/atividade_table.dart';
import 'package:sympla_app/core/storage/tables/checklist/checklist_schema.dart';
import 'package:sympla_app/core/storage/tables/equipamento/equipamento_table.dart';
import 'package:sympla_app/core/storage/tables/equipamento/grupo_defeito_equipamento.dart';
import 'package:sympla_app/core/storage/tables/equipamento/subgrupo_defeito_equipamento.dart';
import 'package:sympla_app/core/storage/tables/prev_bc_bat/prev_bc_bat_schema.dart';
import 'package:sympla_app/core/storage/tables/prev_disj/prev_disj_schema.dart';
import 'package:sympla_app/core/storage/tables/tecnicos_table.dart';
import 'package:sympla_app/core/storage/tables/atividade/tipo_atividade_table.dart';
import 'package:sympla_app/core/storage/tables/usuario_table.dart';
import 'dart:io';

import 'package:sympla_app/core/storage/converters/tipo_atividade_mobile_converter.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';

// ignore: uri_does_not_exist
part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sympla3.sqlite'));

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
    AprTable,
    AprQuestionTable,
    AprRespostaTable,
    AprPerguntaRelacionamentoTable,
    AprPreenchidaTable,
    AprAssinaturaTable,
    TecnicosTable,

    //checklist
    ChecklistGrupoTable,
    ChecklistSubgrupoTable,
    ChecklistPerguntaTable,
    ChecklistRespostaTable,
    DefeitoTable,
    AnomaliaTable,
    CorrecaoAnomaliaTable,
    ChecklistTable,
    ChecklistPerguntaRelacionamentoTable,

    //prev_bc_bat
    FormularioBateriaTable,
    MedicaoElementoBateriaTable,

    //prev_disj
    PrevDisjForm,
    MedicaoResistenciaContatoTable,
    MedicaoResistenciaIsolamentoTable,
    MedicaoTempoOperacaoTable,
    MedicaoPressaoSf6Table,
  ],
  daos: [
    UsuarioDao,
    TipoAtividadeDao,
    AtividadeDao,
    EquipamentoDao,
    GrupoDefeitoEquipamentoDao,
    SubgrupoDefeitoEquipamentoDao,
    AprDao,
    AprPerguntaDao,
    AprRespostaDao,
    AprPreenchidaDao,
    AprAssinaturaDao,
    TecnicosDao,
    AprPerguntaRelacionamentoDao,

    //checklist
    ChecklistGrupoDao,
    ChecklistSubgrupoDao,
    ChecklistPerguntaDao,
    ChecklistRespostaDao,
    DefeitoDao,
    AnomaliaDao,
    CorrecaoAnomaliaDao,
    ChecklistDao,
    ChecklistPerguntaRelacionamentoDao,

    //prev_bc_bat
    FormularioBateriaDao,
    MedicaoElementoBateriaDao,

    //prev_disj
    PrevDisjFormDao,
    MedicaoResistenciaContatoDao,
    MedicaoResistenciaIsolamentoDao,
    MedicaoTempoOperacaoDao,
    MedicaoPressaoSf6Dao,
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
