import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/converters/caracterizacao_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/estado_disjuntor_converter.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/core/storage/converters/fase_isolamento_converter.dart';
import 'package:sympla_app/core/storage/converters/lado_converter.dart';
import 'package:sympla_app/core/storage/converters/posicao_disjuntor_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/prioridade_defeito_converter.dart';
import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_atividade_mobile_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_bateria_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_extinsao_disjutnor_converter.dart';

//**------------------ENTIDADE BASE SYNCABLE --------------- */
abstract class SyncableTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuid => text().named('uuid').withLength(min: 1, max: 100)();

  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();
}

//**------------------ TECNICOS --------------- */
class TecnicoTable extends SyncableTable {
  TextColumn get nome => text().withLength(min: 2, max: 100)();
  TextColumn get matricula => text().withLength(min: 2, max: 100)();
}

//**------------------ USUARIO --------------- */
class UsuarioTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().named('uuid').withLength(min: 1, max: 100)();

  TextColumn get nome => text().withLength(min: 2, max: 100)();
  TextColumn get matricula => text().unique()();
  TextColumn get token => text().nullable()();
  TextColumn get refreshToken => text().nullable()();
  DateTimeColumn get ultimoLogin => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

//**------------------ ATIVIDADE --------------- */

class TipoAtividadeTable extends SyncableTable {
  TextColumn get nome => text().withLength(min: 2, max: 100)();

  TextColumn get tipoAtividadeMobile => text().map(const TipoAtividadeMobileConverter())();
}

class AtividadeTable extends SyncableTable {
  TextColumn get titulo => text().withLength(min: 2, max: 100)();
  TextColumn get ordemServico => text().withLength(min: 2, max: 50)();
  TextColumn get descricao => text().withLength(min: 2, max: 200)();
  TextColumn get subestacao => text().withLength(min: 1, max: 3)();
  TextColumn get status => text().map(const StatusAtividadeConverter())();

  DateTimeColumn get dataLimite => dateTime()();
  DateTimeColumn get dataInicio => dateTime().nullable()();
  DateTimeColumn get dataFim => dateTime().nullable()();

  TextColumn get equipamentoId => text().references(EquipamentoTable, #uuid)();
  TextColumn get tipoAtividadeId => text().references(TipoAtividadeTable, #uuid)();
}

//**------------------ APR --------------- */
class AprTable extends SyncableTable {
  TextColumn get nome => text()();
  TextColumn get descricao => text().nullable()();
}

class AprQuestionTable extends SyncableTable {
  TextColumn get texto => text()();
}

class AprPerguntaRelacionamentoTable extends SyncableTable {
  Column<String> get aprId => text().references(AprTable, #uuid)();
  Column<String> get perguntaId => text().references(AprQuestionTable, #uuid)();
  IntColumn get ordem => integer()();
}

class AprTipoAtividadeTable extends SyncableTable {
  TextColumn get tipoAtividadeId => text().references(TipoAtividadeTable, #uuid)();
  TextColumn get aprId => text().references(AprTable, #uuid)();
}

class AprPreenchidaTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  Column<String> get atividadeId => text().references(AtividadeTable, #uuid)();
  Column<String> get aprId => text().references(AprTable, #uuid)();
  Column<String> get usuarioId => text().references(UsuarioTable, #uuid)();
  DateTimeColumn get dataPreenchimento => dateTime()();
}

class AprRespostaTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get aprPreenchidaId => integer().references(AprPreenchidaTable, #id)();

  Column<String> get perguntaId =>
      text().references(AprQuestionTable, #uuid)(); //Pergunta que respondeu
  TextColumn get resposta => text().map(const RespostaAprConverter())();
  TextColumn get observacao => text().nullable()();
}

class AprAssinaturaTable extends Table {
  //id
  IntColumn get id => integer().autoIncrement()();
  //id da atividade preenchida
  IntColumn get aprPreenchidaId => integer().references(AprPreenchidaTable, #id)();
  //id do usuário
  Column<String> get usuarioId => text().references(UsuarioTable, #uuid)();
  //data da assinatura
  DateTimeColumn get dataAssinatura => dateTime()();
  //id do técnico
  Column<String> get tecnicoId => text().references(TecnicoTable, #uuid)();
  //assinatura em bytes
  BlobColumn get assinatura => blob()();
  //caminho da assinatura
  TextColumn get assinaturaPath => text().nullable()();
}

//**------------------ CHECKLIST --------------- */

class ChecklistTable extends SyncableTable {
  TextColumn get nome => text()();
  TextColumn get descricao => text().nullable()();
}

class ChecklistPerguntaTable extends SyncableTable {
  TextColumn get pergunta => text()();
}

class ChecklistPerguntaRelacionamentoTable extends SyncableTable {
  TextColumn get checklistId => text().references(ChecklistTable, #uuid)();
  TextColumn get perguntaId => text().references(ChecklistPerguntaTable, #uuid)();
  IntColumn get ordem => integer().withDefault(const Constant(0))();
}

class ChecklistTipoAtividadeTable extends SyncableTable {
  TextColumn get checklistId => text().references(ChecklistTable, #uuid)();
  TextColumn get tipoAtividadeId => text().references(TipoAtividadeTable, #uuid)();
}

class ChecklistPreenchidoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get atividadeId => text().references(AtividadeTable, #uuid)();
  TextColumn get checklistId => text().references(ChecklistTable, #uuid)();
  TextColumn get usuarioId => text().references(UsuarioTable, #uuid)();
  DateTimeColumn get dataPreenchimento => dateTime()();
}

class ChecklistRespostaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get checklistPreenchidoId => integer().references(ChecklistPreenchidoTable, #id)();
  TextColumn get perguntaId => text().references(ChecklistPerguntaTable, #uuid)();
  TextColumn get resposta => text().map(const RespostaChecklistConverter())();
}

//**------------------ GRUPO DE DEF EQUIPAMENTO --------------- */

class GrupoDefeitoEquipamentoTable extends SyncableTable {
  TextColumn get nome => text().withLength(min: 2, max: 100)();
  TextColumn get codigo => text().withLength(min: 2, max: 200)();
}

class SubgrupoDefeitoEquipamentoTable extends SyncableTable {
  TextColumn get nome => text().withLength(min: 2, max: 100)();
  TextColumn get grupoDefeitoId => text().references(GrupoDefeitoEquipamentoTable, #uuid)();
}

class DefeitoTable extends SyncableTable {
  TextColumn get grupoId => text().references(GrupoDefeitoEquipamentoTable, #uuid)();
  TextColumn get subgrupoId => text().references(SubgrupoDefeitoEquipamentoTable, #uuid)();

  TextColumn get codigoSap => text()();
  TextColumn get descricao => text()();
  TextColumn get prioridade => text().map(const PrioridadeDefeitoConverter())();
}

//**------------------ EQUIPAMENTO --------------- */

class EquipamentoTable extends SyncableTable {
  TextColumn get nome => text().withLength(min: 2, max: 100)();
  TextColumn get descricao => text().withLength(min: 2, max: 200)();
  TextColumn get subestacao => text().withLength(min: 1, max: 3)();

  TextColumn get grupoId => text().references(GrupoDefeitoEquipamentoTable, #uuid)();
}

//**------------------ ANOMALIA --------------- */
class AnomaliaTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get perguntaId => text()
      .references(ChecklistPerguntaTable, #uuid)
      .nullable()(); // Vinculada só durante o checklist

  TextColumn get atividadeId => text().references(AtividadeTable, #uuid)();
  TextColumn get equipamentoId => text().references(EquipamentoTable, #uuid)();
  TextColumn get defeitoId => text().references(DefeitoTable, #uuid)();

  TextColumn get fase => text().map(const FaseAnomaliaConverter())();
  TextColumn get lado => text().map(const LadoAnomaliaConverter())();
  RealColumn get delta => real().nullable()();
  TextColumn get observacao => text().nullable()();
  BlobColumn get foto => blob().nullable()(); // Imagem tirada na hora
  BoolColumn get corrigida => boolean().withDefault(const Constant(false))();
}

class CorrecaoAnomaliaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get anomaliaId => integer().references(AnomaliaTable, #id)();
  TextColumn get atividadeId => text().references(AtividadeTable, #uuid)();
  BlobColumn get foto => blob().nullable()(); // Pode ser base64 ou caminho local
}

//**------------------ MPBB --------------- */
class FormularioMpbbTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get atividadeId => text().references(AtividadeTable, #uuid)();

  TextColumn get fabricante => text().nullable()();
  RealColumn get resistenciaNominal => real().nullable()();
  RealColumn get densidadeNominal => real().nullable()();
  RealColumn get tensaoFlutuacaoCelula => real().nullable()();
  RealColumn get densidadeCritica => real().nullable()();
  TextColumn get tipoBateria => text().map(const TipoBateriaConverter())();
  TextColumn get modelo => text().nullable()();
  IntColumn get capacidadeAh => integer().nullable()();
  IntColumn get quantidadeCelulas => integer().nullable()();
  RealColumn get tensaoFlutuacaoBanco => real().nullable()();
  RealColumn get rippleMedido => real().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class MedicaoElementoMpbbTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get formularioMpbbId =>
      integer().references(FormularioMpbbTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get elementoBateriaNumero => integer()();
  RealColumn get tensao => real().nullable()();
  RealColumn get resistenciaInterna => real().nullable()();
}

//**------------------ MPDJ --------------- */

class MpDjFormTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get atividadeId => text().references(AtividadeTable, #uuid)();
  TextColumn get caracterizacaoEnsaio =>
      text().map(const CaracterizacaoEnsaioConverter()).nullable()();

  TextColumn get disjuntorFabricante => text().nullable()();
  TextColumn get disjuntorAnoFabricacao => text().nullable()();
  RealColumn get disjuntorTensaoNominal => real().nullable()();
  IntColumn get disjuntorCorrenteNominal => integer().nullable()();
  IntColumn get disjuntorCapInterrupcaoNominal => integer().nullable()();
  TextColumn get disjuntorTipoExtinsao =>
      text().map(const TipoExtinsaoDisjuntorConverter()).nullable()();
  TextColumn get disjuntorTipoAcionamento => text().nullable()();
  RealColumn get disjuntorPressaoSf6Nominal => real().nullable()();
  RealColumn get disjuntorPressaoSf6NominalTemperatura => real().nullable()();

  RealColumn get dadoPlacaFechamento => real().nullable()();
  RealColumn get dadoPlacaAbertura => real().nullable()();

  DateTimeColumn get dataEnsaio => dateTime().withDefault(currentDateAndTime)();
}

class MpDjResistenciaContatoTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mpDjFormId => integer().references(MpDjFormTable, #id)();
  IntColumn get numeroCamara => integer()();

  RealColumn get resistenciaFaseA => real().nullable()();
  RealColumn get resistenciaFaseB => real().nullable()();
  RealColumn get resistenciaFaseC => real().nullable()();

  RealColumn get temperaturaDisjuntor => real().nullable()();
  RealColumn get umidadeRelativaAr => real().nullable()();
}

class MpDjResistenciaIsolamentoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mpDjFormId => integer().references(MpDjFormTable, #id)();

  /// 🔧 Configurações gerais do ensaio (fixas, não mudam por medição)
  RealColumn get tensaoKv => real()();
  RealColumn get temperaturaDisjuntor => real().nullable()();
  RealColumn get umidadeRelativaAr => real().nullable()();
}

class MpDjResistenciaIsolamentoMedicoesTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mpDjResistenciaIsolamentoId =>
      integer().references(MpDjResistenciaIsolamentoTable, #id)();

  DateTimeColumn get dataMedicao => dateTime().withDefault(currentDateAndTime)();

  /// 🔌 Configurações de posição do disjuntor
  TextColumn get linha => text().map(const PosicaoDisjuntorEnsaioConverter())();
  TextColumn get terra => text().map(const PosicaoDisjuntorEnsaioConverter())();
  TextColumn get guarda => text().map(const PosicaoDisjuntorEnsaioConverter())();

  /// ⚡ Fase selecionada para medição
  TextColumn get fase => text().map(const FaseIsolamentoConverter())();

  /// 🔌 Estado do disjuntor durante o ensaio
  TextColumn get estadoDisjuntor => text().map(const EstadoDisjuntorConverter())();

  /// 📊 Medições de resistência (11 campos: 30s, 1min, 2min... até 10min)
  RealColumn get resistencia30s => real().nullable()();
  RealColumn get resistencia1min => real().nullable()();
  RealColumn get resistencia2min => real().nullable()();
  RealColumn get resistencia3min => real().nullable()();
  RealColumn get resistencia4min => real().nullable()();
  RealColumn get resistencia5min => real().nullable()();
  RealColumn get resistencia6min => real().nullable()();
  RealColumn get resistencia7min => real().nullable()();
  RealColumn get resistencia8min => real().nullable()();
  RealColumn get resistencia9min => real().nullable()();
  RealColumn get resistencia10min => real().nullable()();
}

class MpDjTempoOperacaoTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mpDjFormId => integer().references(MpDjFormTable, #id)();

  TextColumn get fase => text().map(const FaseAnomaliaConverter())(); // A, B ou C

  // Tempos normais
  RealColumn get fechamentoBobina1 => real().nullable()();
  RealColumn get fechamentoBobina2 => real().nullable()();

  RealColumn get aberturaBobina1 => real().nullable()();
  RealColumn get aberturaBobina2 => real().nullable()();
}

class MpDjPressaoSf6Table extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mpDjFormId => integer().references(MpDjFormTable, #id)();
  TextColumn get fase => text().map(const FaseAnomaliaConverter())(); // A, B ou C

  RealColumn get valorPressao => real()(); // Ex: 6.30 BAR
  RealColumn get temperatura => real()(); // Em ºC
}
