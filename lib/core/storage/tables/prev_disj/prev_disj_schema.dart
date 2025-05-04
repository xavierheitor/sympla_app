import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/converters/caracterizacao_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/core/storage/converters/posicao_disjuntor_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_extinsao_disjutnor_converter.dart';
import 'package:sympla_app/core/storage/tables/atividade/atividade_table.dart';

class PrevDisjForm extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get atividadeId => integer().references(AtividadeTable, #id)();

  TextColumn get caracterizacaoEnsaio =>
      text().map(const CaracterizacaoEnsaioConverter()).nullable()();

//Dados dos equipamentos
  TextColumn get termohigrometroFabricante => text().nullable()();
  TextColumn get termohigrometroTipo => text().nullable()();
  DateTimeColumn get termohigrometroUltimaCalibracao => dateTime().nullable()();

  TextColumn get micromimetroFabricante => text().nullable()();
  TextColumn get micromimetroTipo => text().nullable()();
  DateTimeColumn get micromimetroUltimaCalibracao => dateTime().nullable()();

  TextColumn get megometroFabricante => text().nullable()();
  TextColumn get megometroTipo => text().nullable()();
  DateTimeColumn get megometroUltimaCalibracao => dateTime().nullable()();

  TextColumn get oscilografoFabricante => text().nullable()();
  TextColumn get oscilografoTipo => text().nullable()();
  DateTimeColumn get oscilografoUltimaCalibracao => dateTime().nullable()();

  //dados do disjuntor
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

  //dados do ensaio
  DateTimeColumn get dataEnsaio => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>>? get uniqueKeys => [
        {atividadeId},
      ];

  @override
  List<String> get customConstraints => ['UNIQUE(atividade_id)'];
}

class MedicaoResistenciaContatoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get formularioDisjuntorId =>
      integer().references(PrevDisjForm, #id)(); // FK futura
  IntColumn get numeroCamara => integer()();

  RealColumn get resistenciaFaseA => real().nullable()();
  RealColumn get resistenciaFaseB => real().nullable()();
  RealColumn get resistenciaFaseC => real().nullable()();

  RealColumn get temperaturaDisjuntor => real().nullable()();
  RealColumn get umidadeRelativaAr => real().nullable()();
}

class MedicaoResistenciaIsolamentoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get formularioDisjuntorId =>
      integer().references(PrevDisjForm, #id)(); // FK futura

  TextColumn get linha => text().map(const PosicaoDisjuntorEnsaioConverter())();
  TextColumn get terra => text().map(const PosicaoDisjuntorEnsaioConverter())();
  TextColumn get guarda =>
      text().map(const PosicaoDisjuntorEnsaioConverter())();

  RealColumn get tensaoKv => real()();

  RealColumn get resistenciaFaseA => real().nullable()(); // em MΩ
  RealColumn get resistenciaFaseB => real().nullable()();
  RealColumn get resistenciaFaseC => real().nullable()();

  RealColumn get temperaturaDisjuntor => real().nullable()();
  RealColumn get umidadeRelativaAr => real().nullable()();
}

class MedicaoTempoOperacaoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get formularioDisjuntorId =>
      integer().references(PrevDisjForm, #id)(); // FK futura
  TextColumn get fase =>
      text().map(const FaseAnomaliaConverter())(); // A, B ou C

  // Tempos normais
  RealColumn get fechamento => real().nullable()();
  RealColumn get aberturaBobina1 => real().nullable()();
  RealColumn get aberturaBobina2 => real().nullable()();

  // Tempos em Trip Free
  RealColumn get fechamentoTripFree => real().nullable()();
  RealColumn get aberturaTripFreeBob1 => real().nullable()();
  RealColumn get aberturaTripFreeBob2 => real().nullable()();

  // Curto-circuito (duas colunas separadas)
  RealColumn get curtoBob1 => real().nullable()();
  RealColumn get curtoBob2 => real().nullable()();

  // Dados de placa
  RealColumn get dadoPlacaFechamento => real().nullable()();
  RealColumn get dadoPlacaAbertura => real().nullable()();
}

class MedicaoPressaoSf6Table extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get formularioDisjuntorId =>
      integer().references(PrevDisjForm, #id)(); // FK futura
  TextColumn get fase =>
      text().map(const FaseAnomaliaConverter())(); // A, B ou C

  RealColumn get valorPressao => real()(); // Ex: 6.30 BAR
  RealColumn get temperatura => real()(); // Em ºC
}
