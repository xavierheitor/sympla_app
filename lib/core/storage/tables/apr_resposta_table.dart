import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';
import 'package:sympla_app/core/storage/tables/apr_preenchida_table.dart';
import 'package:sympla_app/core/storage/tables/apr_question_table.dart';

class AprRespostaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get aprPreenchidaId =>
      integer().references(AprPreenchidaTable, #id)();
  IntColumn get perguntaId =>
      integer().references(AprQuestionTable, #id)(); //Pergunta que respondeu
  TextColumn get resposta => text().map(const RespostaAprConverter())();
  TextColumn get observacao => text().nullable()();
}
